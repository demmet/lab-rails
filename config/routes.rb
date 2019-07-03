Rails.application.routes.draw do
  get 'wirecard/new'
  post 'wirecard/create'
  get 'general/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "general#index"
  post 'wirecard/webhook', to: 'wirecard#store'
end
