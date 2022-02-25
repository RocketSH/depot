Rails.application.routes.draw do
  # chapter 3 tasks
  resources :products

  # chapter 2 task
  get 'say/hello'
  get 'say/goodbye'
end
