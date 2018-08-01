Rails.application.routes.draw do
  namespace :admin do
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
