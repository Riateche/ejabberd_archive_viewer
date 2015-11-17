Rails.application.routes.draw do
  root to: 'visitors#index'
  get 'history/:jid' => 'visitors#view_history', as: :view_history, constraints: { jid: /[^\/]+/ }
end
