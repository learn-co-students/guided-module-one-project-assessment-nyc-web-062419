class CreateSightings < ActiveRecord::Migration[5.2]
  def change
    create_table :sightings do |t|
      t.integer :user_id
      t.integer :location_id
      t.datetime :date
      t.string :shape
    end
  end
end
