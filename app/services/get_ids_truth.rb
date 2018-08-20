class GetIdsTruth
  def self.call ids_question
    Answer.where(question_id: ids_question,
      truth: true).pluck :id
  end
end
