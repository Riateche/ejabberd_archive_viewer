Rails.application.routes.draw do
  root to: 'main#index'
  get 'history/:alias' => 'main#view_history', as: :view_history, constraints: { alias: /[^\/]+/ }
  post 'search/:alias' => 'main#search', as: :search, constraints: { alias: /[^\/]+/ }
  post 'set_alias' => 'main#set_alias', as: :set_alias
end
