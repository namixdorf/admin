class Person < ActiveRecord::Base

  cohesive_admin

  belongs_to :job, counter_cache: true

end
