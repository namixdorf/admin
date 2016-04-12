module CohesiveAdmin::Concerns::Resource
  extend ActiveSupport::Concern

  included do
    # any required hooks here
  end

  def admin_resource?
    self.class.admin_resource?
  end

  module ClassMethods



    def admin_resource?
      false
    end

    def cohesive_admin(args={})


      @blacklisted_columns = ['id', 'created_at', 'updated_at']
      @admin_config = nil
      @admin_strong_params = nil

      CohesiveAdmin.manage(self)

      class_eval do


        def self.admin_resource?
          true
        end

        # CohesiveAdmin configuration for a model can be placed in Rails.root/config/cohesive_admin/model_singular.yml
        def self.admin_config

          unless @admin_config
            # attempt to parse config file
            fname = File.join('config', 'cohesive_admin', "#{ActiveModel::Naming.singular(self)}.yml")
            if File.exists?(CohesiveAdmin::Engine.root.join(fname))
              @admin_config = YAML.load_file(CohesiveAdmin::Engine.root.join(fname))
            elsif File.exists?(CohesiveAdmin.app_root.join(fname))
              @admin_config = YAML.load_file(CohesiveAdmin.app_root.join(fname))
            else
              # construct default config
              @admin_config = {
                'name'    => self.name,
                'fields'  => {}
              }
              # reflections
              reflection_columns = []
              self.reflections.each do |k, r|
                @admin_config['fields'][k] = {
                  'type'        => 'association',
                  'macro'       => r.macro,
                  'foreign_key' => r.foreign_key
                }
                reflection_columns << r.foreign_key
              end

              blacklisted = @blacklisted_columns + reflection_columns

              self.columns.each do |c|
                @admin_config['fields'][c.name] = {
                  'type' => c.type
                } unless blacklisted.include?(c.name)
              end if self.table_exists?

            end
          end
          @admin_config
        end

        def self.admin_fields
          self.admin_config['fields']
        end

        def self.admin_strong_params
          unless @admin_strong_params
            # setup strong parameters from managed fields
            @admin_strong_params = []
            self.admin_fields.each do |k, f|

              if f['type'] == 'association'
                m = f['macro'].to_s
                if m == 'belongs_to'
                  @admin_strong_params << f['foreign_key']
                elsif m == 'has_many'
                  @admin_strong_params << { f['foreign_key'].pluralize => [] }
                end
              else
                @admin_strong_params << k
              end
            end
          end
          @admin_strong_params
        end


      end


    end


  end # class methods

end