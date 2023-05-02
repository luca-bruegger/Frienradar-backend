class AddGeolocation < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :preferred_distance, :integer, default: 0, null: false

    create_table :geolocations, id: :uuid do |t|
      t.string :geohash
      t.references :user, null: false, foreign_key: true, type: :uuid, on_delete: :cascade
      t.timestamps
    end
  end
end
