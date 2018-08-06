class Question < ApplicationRecord
  belongs_to :question_type
  has_many :answers

  accepts_nested_attributes_for :answers
  scope :feed, ->(ids){where question_type_id: ids}
  validates :title, presence: true,
    length: {maximum: Settings.validate.question.title.maxlength}
end
