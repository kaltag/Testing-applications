Rails.application.routes.draw do
  scope '(:locale)', locale: /ru|en/ do
    root to: 'tests#index'

    devise_for :users, controllers: { sessions: 'users/sessions' }, path: :gurus, path_names: { sign_in: :login, sign_out: :logout }

    resources :tests, only: :index do
      member do
        post :start
      end
    end

    resources :test_passages, only: %i[show update] do
      member do
        get :result
      end
    end

    namespace :admin do
      resources :tests do
        patch :update_inline, on: :member

        resources :questions, shallow: true, except: :index do
          resources :answers, shallow: true, except: :index
        end
      end
      resources :gists, only: %i[index]
      resources :badges
    end
    resources :gists, only: %i[create]
    resources :feedbacks, only: %i[new create]

  end
end
