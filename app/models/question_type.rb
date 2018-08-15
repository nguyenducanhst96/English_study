class QuestionType < ApplicationRecord
  belongs_to :topic
  belongs_to :exam, optional: true
  has_many :questions, dependent: :destroy

  accepts_nested_attributes_for :questions
  scope :ids_by_topic, (lambda do |topic_id|
    select(:id).where(topic_id: topic_id)
  end)
  scope :not_belong_to_exam, (lambda do |topic_code|
    where(topic_id: topic_code, exam_id: nil)
      .pluck(:id)
  end)
  scope :get_from_question_ids, (lambda do |ids|
    where(id: Question.get_question_types_ids(ids))
  end)
end
