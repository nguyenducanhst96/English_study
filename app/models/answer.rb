class Answer < ApplicationRecord
  belongs_to :question

  scope :true_answer, ->(question_id){where "question_id = ? and truth = 1", question_id}
end
