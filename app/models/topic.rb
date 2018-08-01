class Topic < ApplicationRecord
  enum code: {grammar: 1, sign: 2, paragraph: 3, fill: 4,
              picture: 5, conversation: 6, writing: 7}
  has_many :exams
  has_many :question_types
end
