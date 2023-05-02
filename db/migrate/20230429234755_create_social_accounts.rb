class CreateSocialAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :social_accounts, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.integer :provider, null: false
      t.string :username, null: false

      t.timestamps
    end

    add_index :social_accounts, [:user_id, :provider], unique: true
  end
end
