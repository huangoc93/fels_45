Rails.application.routes.draw do

  root             'static_pages#home'
  get 'about'   => 'static_pages#about'
  get 'contact' => 'static_pages#contact'

  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  
  resources :users, except: [:destroy]
  resources :relationships, only: [:create, :destroy]
  resources :words, only: [:index]
  resources :categories, only: [:index]

  scope '/lessons' do
    get ':id' => 'lessons#show', as: :lesson
    post ':category_id' => 'lessons#create'
  end

  namespace :admin do
    root 'static_pages#index'
    resources :users,        only:   [:index, :destroy]
    resources :categories,   except: [:show]
    resources :words,        except: [:show]
  end
  
end
