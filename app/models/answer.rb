class Answer < ApplicationRecord
  belongs_to :question

  scope :true_answer,
    ->(question_id){where(question_id: question_id, truth:1)}
  validates :content, presence: true,
    length: {maximum: Settings.validate.answer.content.maxlength}
end
