class QuestionType < ApplicationRecord
  belongs_to :topic
  belongs_to :exam, optional: true
  has_many :questions
end
