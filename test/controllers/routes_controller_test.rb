class RoutesControllerTest < ActionController::TestCase
  test 'should get shortest' do
    get :shortest, { from: 'A', to: 'B', autonomy: 1, fuel_price: 1 }
    assert_response :success
    assert match_response_schema(:shortest)
  end
end