class Exam < ApplicationRecord
  has_many :question_types
  has_many :questions, through: :question_types
  belongs_to :topic

  validates :name, presence: true

  def number_name_exam
    name.split(" ").last.to_i
  end

  def init_name_exam number
    data_name = name.split " "
    data_name[1] = number.to_s
    data_name.join " "
  end
end
