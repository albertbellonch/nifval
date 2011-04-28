require 'test_helper'

class NifsControllerTest < ActionController::TestCase
  setup do
    @nif = nifs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:nifs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create nif" do
    assert_difference('Nif.count') do
      post :create, :nif => @nif.attributes
    end

    assert_redirected_to nif_path(assigns(:nif))
  end

  test "should show nif" do
    get :show, :id => @nif.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @nif.to_param
    assert_response :success
  end

  test "should update nif" do
    put :update, :id => @nif.to_param, :nif => @nif.attributes
    assert_redirected_to nif_path(assigns(:nif))
  end

  test "should destroy nif" do
    assert_difference('Nif.count', -1) do
      delete :destroy, :id => @nif.to_param
    end

    assert_redirected_to nifs_path
  end
end
