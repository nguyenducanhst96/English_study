class CreateQuestionTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :question_types do |t|
      t.text :content
      t.references :topic, foreign_key: true
      t.references :exam, foreign_key: true

      t.timestamps
    end
  end
end
