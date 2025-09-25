require "test_helper"

class BroadcastersPeopleUpdatedTest < ActiveSupport::TestCase
  setup do
    @person = people(:one)
  end

  test "initializes with person" do
    broadcaster = Broadcasters::People::Updated.new(@person)
    assert_equal @person, broadcaster.person
  end

  test "responds to call method" do
    broadcaster = Broadcasters::People::Updated.new(@person)
    assert_respond_to broadcaster, :call
  end
end
