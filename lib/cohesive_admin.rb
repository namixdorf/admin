require "cohesive_admin/engine"
require "cohesive_admin/configuration"

module CohesiveAdmin
  extend ActiveSupport::Autoload

  class << self
    attr_accessor :config
    attr_accessor :app_root

    def config
      self.config = Configuration.new unless @config
      @config
    end

    def manage(klass)
      if self.config.managed_models.select {|k| k.name == klass.name }.empty?
        self.config.managed_models << klass
      end
    end

  end

  def self.configure
    self.config ||= Configuration.new

    yield(self.config)

    after_configure
  end

  def self.after_configure

  end

end
