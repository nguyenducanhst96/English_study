class QuestionType < ApplicationRecord
  belongs_to :topic
  belongs_to :exam, optional: true
  has_many :questions

  scope :ids_by_topic, (lambda do |topic_id|
    select(:id).where(topic_id: topic_id)
  end)
end
