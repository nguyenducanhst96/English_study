class Exam < ApplicationRecord
  has_many :question_types
  has_many :questions, through: :question_types
  belongs_to :topic
end
