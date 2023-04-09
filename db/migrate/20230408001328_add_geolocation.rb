class AddGeolocation < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :preffered_distance, :integer, default: 0, null: false

    create_table :geolocations do |t|
      t.string :guid, null: false
      t.string :geohash
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
