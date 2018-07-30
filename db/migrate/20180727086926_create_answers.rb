class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.string :content
      t.boolean :truth, default: false
      t.references :question, foreign_key: true
      t.integer :user_track_id

      t.timestamps
    end
  end
end
