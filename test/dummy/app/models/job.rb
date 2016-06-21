class Job < ActiveRecord::Base

  cohesive_admin
  has_many :people
end
