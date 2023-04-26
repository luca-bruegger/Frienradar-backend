class AddGeolocation < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :preferred_distance, :integer, default: 0, null: false

    create_table :geolocations do |t|
      t.string :geohash
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
