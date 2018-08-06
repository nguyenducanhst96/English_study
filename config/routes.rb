Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  root "listening_questions#index"
  namespace :admin do
    scope :question do
      namespace :listening, path: '/' do
        resources :listening_questions
      end
      namespace :reading, path: '/' do
        resources :reading_questions
      end
      namespace :writing, path: '/' do
        resources :writing_questions 
        resources :questions
      end
    end
    scope :exam do
      namespace :reading, path: '/' do
        resources :reading_exams
      end
      namespace :listening, path: '/' do
        resources :listening_exams
      end
      namespace :writing, path: '/' do
        resources :writing_exams
      end
    end
  end
end
