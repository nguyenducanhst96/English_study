module Admin::Reading::GrammarExamsHelper
  def get_truth_answer question
    Answer.true_answer(question.id).first &. content
  end
end
