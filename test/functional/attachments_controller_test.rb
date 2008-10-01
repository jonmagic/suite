require 'test_helper'

class AttachmentsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:attachments)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_attachment
    assert_difference('Attachment.count') do
      post :create, :attachment => { }
    end

    assert_redirected_to attachment_path(assigns(:attachment))
  end

  def test_should_show_attachment
    get :show, :id => attachments(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => attachments(:one).id
    assert_response :success
  end

  def test_should_update_attachment
    put :update, :id => attachments(:one).id, :attachment => { }
    assert_redirected_to attachment_path(assigns(:attachment))
  end

  def test_should_destroy_attachment
    assert_difference('Attachment.count', -1) do
      delete :destroy, :id => attachments(:one).id
    end

    assert_redirected_to attachments_path
  end
end
