require "application_system_test_case"

class PeopleTest < ApplicationSystemTestCase
  setup do
    @person = people(:one)
  end

  test "visiting the index" do
    visit people_url
    assert_selector "h1", text: "People"
    within "#people-counter" do
      assert_text Person.count
    end
  end

  test "should create person" do
    visit people_url
    click_on "New person"

    fill_in "Address", with: @person.address
    fill_in "Date of birth", with: @person.date_of_birth
    fill_in "First name", with: @person.first_name
    fill_in "Last name", with: @person.last_name
    fill_in "Phone", with: @person.phone
    click_on "Create Person"

    assert_text "Person was successfully created"
    click_on "Back"
  end

  test "should update Person" do
    visit person_url(@person)
    click_on "Edit this person", match: :first

    fill_in "Address", with: @person.address
    fill_in "Date of birth", with: @person.date_of_birth
    fill_in "First name", with: @person.first_name
    fill_in "Last name", with: @person.last_name
    fill_in "Phone", with: @person.phone
    click_on "Update Person"

    assert_text "Person was successfully updated"
    click_on "Back"
  end

  test "should destroy Person" do
    visit person_url(@person)
    accept_confirm { click_on "Destroy this person", match: :first }

    assert_text "Person was successfully destroyed"
  end
end
