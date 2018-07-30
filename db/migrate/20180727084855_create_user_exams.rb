class CreateUserExams < ActiveRecord::Migration[5.2]
  def change
    create_table :user_exams do |t|
      t.references :exam, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :point

      t.timestamps
    end
  end
end
