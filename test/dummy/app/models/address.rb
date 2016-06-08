class Address < ActiveRecord::Base

  cohesive_admin

  validates :street,  presence: true
  validates :city,    presence: true
  validates :state,   presence: true

  belongs_to :location, inverse_of: :addresses
end
