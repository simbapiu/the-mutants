Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'people#stats'
  post '/mutant', to: 'people#mutant'
end
