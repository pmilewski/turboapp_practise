require "test_helper"

class CounterControllerTest < ActionDispatch::IntegrationTest
  include ActionCable::TestHelper

  setup do
    # Clear the kredis counter to ensure a clean state for each test
    Kredis.counter("counter1").del
  end

  test "should get show" do
    get counter_url
    assert_response :success
  end

  test "should increment counter and broadcast update" do
    assert_equal 0, Kredis.counter("counter1").value

    assert_turbo_stream_broadcasts :counter1_stream do
      post increment_url
    end

    assert_response :success
    assert_equal 1, Kredis.counter("counter1").value
  end

  test "should decrement counter and broadcast update" do
    Kredis.counter("counter1").increment(by: 5)

    assert_turbo_stream_broadcasts :counter1_stream do
      post decrement_url
    end

    assert_response :success
    assert_equal 4, Kredis.counter("counter1").value
  end
end
