class Question < ApplicationRecord
  belongs_to :question_type
  has_many :answers

  scope :feed, ->(ids){where question_type_id: ids}
end
