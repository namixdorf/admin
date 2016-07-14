class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|

      t.string    :street
      t.string    :city
      t.string    :state
      t.string    :zip
      t.text      :description

      t.belongs_to :location

      t.timestamps null: false
    end
  end
end
