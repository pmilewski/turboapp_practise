class PeopleController < ApplicationController
  before_action :set_person, only: %i[ show edit update destroy hovercard ]

  # GET /people or /people.json
  def index
    @people = Person.order(created_at: :desc)
  end

  # GET /people/1 or /people/1.json
  def show
  end

  def hovercard
  end

  # GET /people/new
  def new
    @person = Person.new
  end

  # GET /people/1/edit
  def edit
  end

  # POST /people or /people.json
  def create
    @person = Person.new(person_params)

    respond_to do |format|
      if @person.save
        Broadcasters::People::Created.new(@person).call
        format.html { redirect_to @person, notice: "Person was successfully created." }
        format.json { render :show, status: :created, location: @person }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /people/1 or /people/1.json
  def update
    respond_to do |format|
      if @person.update(person_params)
        Broadcasters::People::Updated.new(@person).call
        format.html { redirect_to @person, notice: "Person was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @person }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1 or /people/1.json
  def destroy
    @person.destroy!

    respond_to do |format|
      Broadcasters::People::Destroyed.new(@person).call

      format.html { redirect_to people_path, notice: "Person was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def person_params
      params.expect(person: [ :first_name, :last_name, :address, :phone, :date_of_birth ])
    end
end
