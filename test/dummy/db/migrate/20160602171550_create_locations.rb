class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|

      t.string    :slug,      limit: 20
      t.string    :address
      t.string    :city
      t.string    :state
      t.string    :zip

      t.timestamps null: false
    end
    add_index :locations, :slug
  end
end
