class Location < ActiveRecord::Base

  cohesive_admin({ finder: :find_by_slug })

  # has_one :address, inverse_of: :location
  has_many :addresses, inverse_of: :location

  attachment :image, type: :image

  accepts_nested_attributes_for :addresses

  validates :slug, presence: true, uniqueness: true, format: { with: /\A[a-z0-9]*\Z/i, message: "must only include letters and numbers" }

  def to_param
    slug
  end

end
