class Topic < ApplicationRecord
  has_many :exams
  has_many :question_types
end
