class Location < ActiveRecord::Base

  cohesive_admin({ finder: :find_by_slug })

  validates :slug, presence: true, uniqueness: true, format: { with: /\A[a-z0-9]*\Z/i, message: "must only include letters and numbers" }

  def to_param
    slug
  end

end
