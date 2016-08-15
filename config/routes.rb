Rails.application.routes.draw do
    root "support_requests#index"
    resources :support_requests

    get "/search" => "support_requests#search"
    post "/search" => "support_requests#search"


end
