class CitiesControllerTest < ActionController::TestCase
  test 'should get index' do
    get :index
    assert_response :success
    assert match_response_schema(:city, true)
  end

  test 'should get destinations' do
    get :destinations
    assert_response :success
    assert match_response_schema(:destinations)
  end

  test 'should delete destroy' do
    delete :destroy, { id: 1 }
    assert_response :success
    assert_not City.where(id: 1).exists?
  end

  test 'should post create' do
    routes_count = Route.count
    cities_count = City.count

    post :create, { city: { name: 'D', map_name: 'foo', routes: [
      { to: 'F', distance: 2 },
      { to: 'E', distance: 3 }
    ]}}

    assert_response :success
    assert match_response_schema(:city)
  end

  test 'should put update' do
    put :update, { id: 1, city: { name: 'foo'}}

    assert_response :success
    assert_equal 'Foo', City.find(1).name
    assert match_response_schema(:city)
  end
end