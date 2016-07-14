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
        ActiveRecord::Base.send(:include, CohesiveAdmin::Concerns::Sortable)
      end
    end

    initializer "cohesive_admin.load_app_root" do |app|
       CohesiveAdmin.app_root = app.root
    end

    # initializer 'cohesive_admin.setup_models' do
    #
    #   ActiveSupport.on_load(:active_record) do
    #     # Rails.application.eager_load!
    #     # puts "ABCDEFG: #{CohesiveAdmin.config.managed_models.length}"
    #     # CohesiveAdmin.config.managed_models.each do |m|
    #     #   puts "#{m.name}"
    #     #   m.admin_setup
    #     # end
    #   end
    #
    # end

  end
end
