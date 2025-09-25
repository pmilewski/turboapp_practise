class Broadcasters::People::Updated
  attr_reader :person

  def initialize(person)
    @person = person
  end

  def call
    update_people_list
  end

  private

    def update_people_list
      Turbo::StreamsChannel.broadcast_update_to :people_list,
      target: @person,
      partial: "people/person",
      locals: { person: @person }
    end
end
