class Question < ApplicationRecord
  belongs_to :question_type
  has_many :answers
end
