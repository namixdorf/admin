class Address < ActiveRecord::Base

  cohesive_admin

  validates :street,  presence: true
  validates :city,    presence: true
  validates :state,   presence: true

  belongs_to :locatable, polymorphic: true
  validates :locatable_type, inclusion: { in: ['Person', 'Location'] }
end
