class MapsControllerTest < ActionController::TestCase
  test 'should get index' do
    get :index
    assert_response :success
    assert match_response_schema(:map, true)
  end

  test 'should delete destroy' do
    delete :destroy, { id: 1 }
    assert_response :success
    assert_not Map.where(id: 1).exists?
  end

  test 'should post create' do
    post :create, { map: { name: 'c' }}

    assert_response :success
    assert match_response_schema(:map)
  end

  test 'should put update' do
    put :update, { id: 1, map: { name: 'foo'}}

    assert_response :success
    assert_equal 'FOO', Map.find(1).name
    assert match_response_schema(:map)
  end
end