Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :v1 do
    get "/products" => "products#index"
    post "/products" => "products#create"
    get "/products/:id" => "products#show"
    patch "/products/:id" => "products#update"
    delete "/products/:id" => "products#destroy"

    post "/orders" => "orders#create"

    post "/users" => "users#create"
  end

  namespace :v2 do
    get "/all_products_url" => "products#all_products_method"
    get "/first_product_url" => "products#first_product_method"
    get "/second_product_url" => "products#second_product_method"
    get "/third_product_url" => "products#third_product_method"
  end
end
