class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.string :email

      t.belongs_to :job

      t.timestamps null: false
    end
  end
end