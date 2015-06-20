Rails.application.routes.draw do
  get 'routes/shortest/:from/:to/:autonomy/:fuel_price' => 'routes#shortest'

  resources :cities, only: [:index, :create, :update, :destroy] do
    collection do
      get 'destinations' => 'cities#destinations'
    end
  end
end
