class CreateInvitations < ActiveRecord::Migration[7.0]
  def change
    create_table :invitations, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :friend_id, null: false, type: :uuid
      t.boolean :confirmed, default: false

      t.timestamps
    end

    add_index :invitations, [:user_id, :friend_id], unique: true
  end
end
