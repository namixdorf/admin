class Job < ActiveRecord::Base

  cohesive_admin
  has_many :people

  scope :sorted, -> { order(:position) }


  def as_json(options={})
    super({ only: [:id, :name] }.merge(options))
  end
  
end
