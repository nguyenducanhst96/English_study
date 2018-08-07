class Question < ApplicationRecord
  belongs_to :question_type
  has_many :answers

  accepts_nested_attributes_for :answers
  validates :title, presence: true,
    length: {maximum: Settings.validate.question.title.maxlength}

  scope :feed, ->(ids){where question_type_id: ids}
  scope :not_belong_to_exam, (lambda do |topic_code|
    where(question_type_id: QuestionType.not_belong_to_exam(topic_code))
  end)
  scope :get_question_types_ids, (lambda do |question_ids|
    where(id: question_ids)
      .pluck(:question_type_id)
  end)
end
