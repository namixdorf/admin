CohesiveAdmin::Engine.routes.draw do

    root to: "dashboard#index"

    resources :sessions do
      collection do
        get :forgot_password
        post :reset_password
        get :logout
      end
    end
    
    CohesiveAdmin::Engine.eager_load!
    Rails.application.eager_load!

    CohesiveAdmin.config.managed_models.each do |m|
      resources ActiveModel::Naming.route_key(m), controller: :base, defaults: { class_name: m.name } do #, constraints: { class_name: Regexp.new("^#{m.name}$") }#, concerns: :paginatable
        collection do
          if m.admin_config && m.admin_sortable?
            get :sort
            put :apply_sort
          end
        end
      end
    end
end
