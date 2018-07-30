class CreateUserTracks < ActiveRecord::Migration[5.2]
  def change
    create_table :user_tracks do |t|
      t.references :user_exam, foreign_key: true
      t.references :question, foreign_key: true

      t.timestamps
    end
  end
end
