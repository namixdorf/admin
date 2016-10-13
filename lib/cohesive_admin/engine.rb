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
      ActiveSupport::Reloader.to_prepare do
        ActiveRecord::Base.send(:include, CohesiveAdmin::Concerns::Resource)
        ActiveRecord::Base.send(:include, CohesiveAdmin::Concerns::Sortable)
      end
    end

    initializer "cohesive_admin.load_app_root" do |app|
       CohesiveAdmin.app_root = app.root
    end

    initializer "cohesive_admin.precompile_images" do |app|
       app.config.assets.precompile += ['cohesive_admin/preloader.gif']
    end

  end
end
