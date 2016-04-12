require_dependency "cohesive_admin/application_controller"

module CohesiveAdmin
  class DashboardController < ApplicationController


      def index
        @header = "Dashboard"
      end

  end
end
