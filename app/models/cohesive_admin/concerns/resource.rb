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


      @blacklisted_columns  = [:id, :created_at, :updated_at]
      @admin_args           = args
      @admin_config         = nil
      @admin_strong_params  = nil
      @display_name_method  = nil
      @admin_fields         = nil

      CohesiveAdmin.manage(self)


      class_eval do

        # Instance display name
        def admin_display_name
          self.send(self.class.display_name_method)
        end
        alias_method :to_label, :admin_display_name



        class << self

          def admin_resource?
            true
          end

          def admin_find(id)
            send admin_config[:finder], id
          end

          def parse_yaml(file)
            config = YAML.load_file(file).symbolize_keys
          end

          # CohesiveAdmin configuration for a model can be placed in Rails.root/config/cohesive_admin/model_singular.yml
          def admin_config

            unless @admin_config


              # defaults updated with args from model (ie. cohesive_admin({ finder: :find_by_slug }))
              @admin_config = {
                name: self.name,
                finder: :find,
                fields: {}
              }.merge(@admin_args.symbolize_keys)

              # attempt to parse config file
              fname = File.join('config', 'cohesive_admin', "#{ActiveModel::Naming.singular(self)}.yml")
              if File.exists?(CohesiveAdmin::Engine.root.join(fname))
                # CohesiveAdmin core models
                @admin_config.update( YAML.load_file(CohesiveAdmin::Engine.root.join(fname)).symbolize_keys )
              elsif File.exists?(CohesiveAdmin.app_root.join(fname))
                # user created models
                @admin_config.update( YAML.load_file(CohesiveAdmin.app_root.join(fname)).symbolize_keys )
              else
                # construct default config

                # reflections - ie. belongs_to, has_many
                self.reflections.each do |k, r|
                  next if r.polymorphic? # have to skip polymorphic associations

                  # omit has_one relationships by default, unless they are accepts_nested_attributes_for AND flagged as an admin_resource
                  next if r.macro == :has_one && (!self.nested_attributes_options.symbolize_keys.has_key?(k.to_sym) || !r.klass.admin_resource?)


                  @admin_config[:fields][k.to_sym] = 'association'
                  # omit foreign key columns
                  @blacklisted_columns << r.foreign_key.to_sym
                end

                self.columns.each do |c|
                  @admin_config[:fields][c.name.to_sym] = {
                    type: c.type
                  } unless @blacklisted_columns.include?(c.name.to_sym)
                end if self.table_exists?

              end
            end
            @admin_config
          end

          def admin_fields
            unless @admin_fields
              @admin_fields = {}
              self.admin_config[:fields].each do |k, field|

                if field.is_a?(String)
                  # parse
                  if field == 'association'
                    r = self.reflections[k.to_s]
                    @admin_fields[k] = {
                      type:           'association',
                      macro:          r.macro,
                      foreign_key:    r.foreign_key, #r.association_foreign_key,
                      class:          r.klass,
                      nested:         self.nested_attributes_options.symbolize_keys.has_key?(k.to_sym)
                    }
                  else
                    @admin_fields[k] = { type: field }
                  end
                else
                  @admin_fields[k] = field
                end
              end
            end
            @admin_fields
          end

          def display_name_method
            unless @display_name_method
              # admin_fields['display_name_method'], self.name, or first admin_fields attribute, finally ID
              if (dn = self.admin_fields['display_name_method']) && (self.attribute_method?(dn) || self.method_defined?(dn))
                @display_name_method = dn
              elsif self.attribute_method?(:name) || self.method_defined?(:name)
                @display_name_method = :name
              else
                # iterate admin_fields until we find the first suitable attribute - NOT IDEAL!!
                self.admin_fields.each do |k,f|
                  next if f[:type] == 'association'
                  break if (self.attribute_method?(k) || self.method_defined?(k)) && @display_name_method = k
                end
              end
              @display_name_method = :id if @display_name_method.blank?
            end
            @display_name_method
          end

          # Class display name
          def admin_display_name
            self.admin_config[:name] || self.name
          end

          def admin_strong_params
            unless @admin_strong_params
              # setup strong parameters from managed fields
              @admin_strong_params = []
              a = {}

              self.admin_fields.each do |k, f|

                if f[:type] == 'association'

                  if f[:nested]
                    a["#{k}_attributes".to_sym] = [:id] + f[:class].admin_strong_params

                  elsif f[:macro] == :belongs_to
                    @admin_strong_params << f[:foreign_key]

                  elsif f[:macro] == :has_many
                    @admin_strong_params << { f[:foreign_key].pluralize => [] }
                  end

                else
                  @admin_strong_params << k
                end
              end

              @admin_strong_params << a
            end
            @admin_strong_params
          end

        end # end class << self


      end


    end


  end # class methods

end
