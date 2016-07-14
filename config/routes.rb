CohesiveAdmin::Engine.routes.draw do

    root to: "dashboard#index"

    resources :sessions do
      collection do
        get :forgot_password
        post :reset_password
        get :logout
      end
    end
    # resources :users, controller: :base, defaults: { class_name: "CohesiveAdmin::User" }, constraints: { class_name: "CohesiveAdmin::User" }

    # kaminari routing ( ie. /page/4 )
    # concern :paginatable do
    #   get '(page/:page)', :action => :index, :on => :collection, :as => ''
    # end

    CohesiveAdmin::Engine.eager_load!
    Rails.application.eager_load!

    CohesiveAdmin.config.managed_models.each do |m|
      resources ActiveModel::Naming.route_key(m), controller: :base, defaults: { class_name: m.name } do #, constraints: { class_name: Regexp.new("^#{m.name}$") }#, concerns: :paginatable
        collection do
          if m.admin_sortable?
            get :sort
            put :apply_sort
          end
        end
      end
    end
end
