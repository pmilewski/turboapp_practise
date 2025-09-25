class Broadcasters::People::Destroyed
  attr_reader :person

  def initialize(person)
    @person = person
  end

  def call
    update_people_list
    update_people_count
  end

  private

    def update_people_list
      Turbo::StreamsChannel.broadcast_remove_to :people_list, target: @person
    end

    def update_people_count
      Turbo::StreamsChannel.broadcast_replace_to :people_list,
        target: "people-counter",
        partial: "people/counter",
        locals: { counter: Person.count }
    end
end
