require 'cohesive_admin/dependencies'

module CohesiveAdmin
  class Engine < ::Rails::Engine
    isolate_namespace CohesiveAdmin


    config.generators do |g|
      g.stylesheets     false
      g.javascripts     false
      g.helper          false
    end

    initializer 'cohesive_admin.include_concerns' do
      ActionDispatch::Reloader.to_prepare do
        ActiveRecord::Base.send(:include, CohesiveAdmin::Concerns::Resource)
      end
    end

    initializer "cohesive_admin.load_app_root" do |app|
       CohesiveAdmin.app_root = app.root
    end

  end
end
