class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_message, only: %i[ show edit update destroy upvote downvote bookmark ]

  # GET /messages or /messages.json
  def index
    @messages = Message.order(cached_weighted_like_score: :desc, created_at: :desc)
  end

  # GET /messages/1 or /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
    respond_to do |format|
      format.turbo_stream { render_form }
      format.html
    end
  end

  # POST /messages or /messages.json
  def create
    @message = Message.new(message_params)
    if @message.save
      handle_success("Message was successfully created.", :create)
    else
      handle_failure(:create)
    end
  end

  # PATCH/PUT /messages/1 or /messages/1.json
  def update
    if @message.update(message_params)
      handle_success("Message was successfully updated.", :update)
    else
      handle_failure(:update)
    end
  end

  def bookmark
    vote_and_respond(:bookmark, "bookmarked")
  end

  def upvote
    vote_and_respond(:upvote, "upvoted")
  end

  def downvote
    vote_and_respond(:downvote, "downvoted")
  end

  # DELETE /messages/1 or /messages/1.json
  def destroy
    @message.destroy!
    handle_success("Message was successfully destroyed.",  :destroy)
  end

  private

  def set_message
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:body)
  end

  def vote_and_respond(vote_type, flash_message)
    if @message.send("#{vote_type}!", current_user)
      flash.now[:notice] = "Message was successfully #{flash_message}."
    else
      flash.now[:alert] = "An error occurred while voting."
    end
    respond_to_vote
  end

  def handle_success(notice, action)
    flash.now[:notice] = notice
    respond_to do |format|
      format.turbo_stream { render_success_turbo_stream(action) }
      format.html { redirect_to @message, status: :see_other }
      format.json { render :show, status: :ok, location: @message }
    end
  end

  def handle_failure(action)
    respond_to do |format|
      format.turbo_stream { render_failure_turbo_stream(action) }
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: @message.errors, status: :unprocessable_entity }
    end
  end

  def render_success_turbo_stream(action)
    case action
    when :create
      render turbo_stream: [
        turbo_stream.update("new_message", partial: "messages/form", locals: { message: Message.new }),
        turbo_stream.prepend("messages", partial: "messages/message", locals: { message: @message }),
        turbo_stream.update("message_counter", Message.count),
        turbo_stream.prepend("flash", partial: "layouts/flash")
      ]
    when :update
      render turbo_stream: [
        turbo_stream.update(@message, partial: "messages/message", locals: { message: @message }),
        turbo_stream.prepend("flash", partial: "layouts/flash")
      ]
    when :destroy
      render turbo_stream: [
        turbo_stream.remove(@message),
        turbo_stream.update("message_counter", Message.count),
        turbo_stream.prepend("flash", partial: "layouts/flash")
      ]
    end
  end

  def render_failure_turbo_stream(action)
    case action
    when :create
      render turbo_stream: turbo_stream.update("new_message", partial: "messages/form", locals: { message: @message })
    when :update
      render turbo_stream: turbo_stream.update(@message, partial: "messages/form", locals: { message: @message })
    end
  end

  def render_form
    render turbo_stream: turbo_stream.update(@message, partial: "messages/form", locals: { message: @message })
  end

  def respond_to_vote
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(@message, partial: "messages/message", locals: { message: @message })
      end
      format.html { redirect_to messages_path, status: :see_other }
      format.json { render :show, status: :ok, location: @message }
    end
  end
end
