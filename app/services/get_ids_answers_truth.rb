class GetIdsAnswersTruth
  def self.call ids_question
    Answer.ids_truth_for_questions ids_question
  end
end
