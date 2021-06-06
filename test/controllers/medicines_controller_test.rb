# frozen_string_literal: true

require "test_helper"

class MedicinesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get medicines_index_url
    assert_response :success
  end

  test "should get show" do
    get medicines_show_url
    assert_response :success
  end

  test "should get new" do
    get medicines_new_url
    assert_response :success
  end

  test "should get edit" do
    get medicines_edit_url
    assert_response :success
  end
end
