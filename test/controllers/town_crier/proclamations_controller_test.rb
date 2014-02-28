require 'test_helper'

module TownCrier
  class ProclamationsControllerTest < ActionController::TestCase
    setup do
      @proclamation = proclamations(:one)
    end

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:proclamations)
    end

    test "should get new" do
      get :new
      assert_response :success
    end

    test "should create proclamation" do
      assert_difference('Proclamation.count') do
        post :create, proclamation: {  }
      end

      assert_redirected_to proclamation_path(assigns(:proclamation))
    end

    test "should show proclamation" do
      get :show, id: @proclamation
      assert_response :success
    end

    test "should get edit" do
      get :edit, id: @proclamation
      assert_response :success
    end

    test "should update proclamation" do
      patch :update, id: @proclamation, proclamation: {  }
      assert_redirected_to proclamation_path(assigns(:proclamation))
    end

    test "should destroy proclamation" do
      assert_difference('Proclamation.count', -1) do
        delete :destroy, id: @proclamation
      end

      assert_redirected_to proclamations_path
    end
  end
end
