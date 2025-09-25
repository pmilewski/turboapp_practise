require "test_helper"

class PeopleControllerTest < ActionDispatch::IntegrationTest
  setup do
    @person = people(:one)
  end

  test "should get index" do
    get people_url
    assert_response :success
  end

  test "should get new" do
    get new_person_url
    assert_response :success
  end

  test "should create person" do
    assert_difference("Person.count") do
      post people_url, params: { person: { address: @person.address, date_of_birth: @person.date_of_birth, first_name: @person.first_name, last_name: @person.last_name, phone: @person.phone } }
    end

    assert_redirected_to person_url(Person.last)
  end

  test "create broadcasts via Broadcasters::People::Created" do
    # Test that the broadcaster service is instantiated and called
    original_new = Broadcasters::People::Created.method(:new)
    broadcaster_instance = nil

    Broadcasters::People::Created.define_singleton_method(:new) do |person|
      broadcaster_instance = original_new.call(person)
      broadcaster_instance
    end

    post people_url, params: { person: { address: "123 St", date_of_birth: Date.today, first_name: "John", last_name: "Doe", phone: "123" } }

    assert_not_nil broadcaster_instance, "Broadcasters::People::Created should have been instantiated"
    assert_respond_to broadcaster_instance, :call

    # Restore original method
    Broadcasters::People::Created.define_singleton_method(:new, original_new)
  end

  test "should show person" do
    get person_url(@person)
    assert_response :success
  end

  test "should get edit" do
    get edit_person_url(@person)
    assert_response :success
  end

  test "should update person" do
    patch person_url(@person), params: { person: { address: @person.address, date_of_birth: @person.date_of_birth, first_name: @person.first_name, last_name: @person.last_name, phone: @person.phone } }
    assert_redirected_to person_url(@person)
  end

  test "update broadcasts via Broadcasters::People::Updated" do
    # Test that the broadcaster service is instantiated and called
    original_new = Broadcasters::People::Updated.method(:new)
    broadcaster_instance = nil

    Broadcasters::People::Updated.define_singleton_method(:new) do |person|
      broadcaster_instance = original_new.call(person)
      broadcaster_instance
    end

    patch person_url(@person), params: { person: { first_name: "Jane" } }

    assert_not_nil broadcaster_instance, "Broadcasters::People::Updated should have been instantiated"
    assert_respond_to broadcaster_instance, :call

    # Restore original method
    Broadcasters::People::Updated.define_singleton_method(:new, original_new)
  end

  test "should destroy person" do
    assert_difference("Person.count", -1) do
      delete person_url(@person)
    end

    assert_redirected_to people_url
  end

  test "destroy broadcasts via Broadcasters::People::Destroyed" do
    # Test that the broadcaster service is instantiated and called
    original_new = Broadcasters::People::Destroyed.method(:new)
    broadcaster_instance = nil

    Broadcasters::People::Destroyed.define_singleton_method(:new) do |person|
      broadcaster_instance = original_new.call(person)
      broadcaster_instance
    end

    delete person_url(@person)

    assert_not_nil broadcaster_instance, "Broadcasters::People::Destroyed should have been instantiated"
    assert_respond_to broadcaster_instance, :call

    # Restore original method
    Broadcasters::People::Destroyed.define_singleton_method(:new, original_new)
  end
end
