class Answer < ApplicationRecord
  belongs_to :question

  scope :true_answer,
    ->(question_id){where(question_id: question_id, truth: 1)}
  mount_uploader :picture, PictureUploader
  scope :ids_truth_for_questions, (lambda do |ids_question|
    where(question_id: ids_question, truth: true).pluck :id
  end)
end
