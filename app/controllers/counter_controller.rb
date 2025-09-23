class CounterController < ApplicationController
  before_action :counter

  def show
  end

  def increment
    counter.increment
    broadcast_counter
  end

  def decrement
    counter.decrement
    broadcast_counter
  end

  private

    def counter
      @counter ||= Kredis.counter "counter1"
    end

    def broadcast_counter
      Turbo::StreamsChannel.broadcast_update_to(:counter1_stream, target: :counter1, html: counter.value)
    end
end
