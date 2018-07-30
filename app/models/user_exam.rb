class UserExam < ApplicationRecord
  belongs_to :exam
  belongs_to :user
  has_many :user_tracks
  has_many :questions, through: :user_tracks
end
