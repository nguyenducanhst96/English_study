class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :password_digest
      t.string :remember_digest
      t.string :activation_digest
      t.string :reset_digest
      t.boolean :active_status
      t.datetime :activated_at
      t.datetime :reset_sent_at
      t.boolean :admin
      t.integer :total_point

      t.timestamps
    end
  end
end
