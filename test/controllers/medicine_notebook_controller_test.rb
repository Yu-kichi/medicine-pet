# frozen_string_literal: true

require "test_helper"

class MedicineNotebookControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get medicine_notebook_index_url
    assert_response :success
  end
end
