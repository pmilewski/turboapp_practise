require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task = tasks(:one)
  end

  test "should get index" do
    get tasks_url
    assert_response :success
  end

  test "should get new" do
    get new_task_url
    assert_response :success
  end

  test "should create task" do
    assert_difference("Task.count") do
      post tasks_url, params: { task: { body: @task.body, name: @task.name, list_id: lists(:one).id } }
    end

    assert_redirected_to task_url(Task.last)
  end

  test "should show task" do
    get task_url(@task)
    assert_response :success
  end

  test "should get edit" do
    get edit_task_url(@task)
    assert_response :success
  end

  test "should update task" do
    patch task_url(@task), params: { task: { body: @task.body, name: @task.name } }
    assert_redirected_to task_url(@task)
  end

  test "should destroy task" do
    assert_difference("Task.count", -1) do
      delete task_url(@task)
    end

    assert_redirected_to tasks_url
  end

  test "should sort task and optionally move to another list" do
    target_list = lists(:two)

    put sort_task_url(@task), params: { row_order_position: 0, list_id: target_list.id }

    assert_response :no_content
    assert_equal target_list.id, @task.reload.list_id
  end

  test "should sort task within the same list when list_id not provided" do
    current_list_id = @task.list_id

    put sort_task_url(@task), params: { row_order_position: 1 }

    assert_response :no_content
    assert_equal current_list_id, @task.reload.list_id
  end
end
