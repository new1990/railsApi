Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  resources :posts
  post "comment_create" => "posts#comment_create"
  get "result" => "posts#result"

end
