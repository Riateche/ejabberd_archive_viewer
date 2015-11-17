Rails.application.routes.draw do
  root to: 'visitors#index'
  get 'history/:alias' => 'visitors#view_history', as: :view_history, constraints: { alias: /[^\/]+/ }
  post 'search/:alias' => 'visitors#search', as: :search, constraints: { alias: /[^\/]+/ }
  post 'set_alias' => 'visitors#set_alias', as: :set_alias
end
