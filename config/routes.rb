CohesiveAdmin::Engine.routes.draw do

    root to: "dashboard#index"

    resources :sessions do
      collection do
        get :forgot_password
        post :reset_password
        get :logout
      end
    end
    resources :users, controller: :base, defaults: { class_name: "CohesiveAdmin::User" }

    Rails.application.eager_load!
    CohesiveAdmin.config.managed_models.each do |m|
      resources ActiveModel::Naming.plural(m), controller: :base, defaults: { class_name: m.name }
    end
end
