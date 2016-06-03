class Address < ActiveRecord::Base

  validates :street,  presence: true
  validates :city,    presence: true
  validates :state,   presence: true

  belongs_to :location
end
