Rails.application.routes.draw do
  resources :people do
    get "points" => "points#index"
    post "points/:points" => "points#create"
  end
end
