class UserTrack < ApplicationRecord
  belongs_to :user_exam
  belongs_to :question
  has_one :answer
end
