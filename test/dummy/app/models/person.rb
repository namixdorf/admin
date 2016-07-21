class Person < ActiveRecord::Base

  cohesive_admin

  belongs_to :job, counter_cache: true

  has_one :address, as: :locatable

end
