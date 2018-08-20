class CreateInfoAnswers
  def self.call data
    array_ids = data["answers"].select{|x| x["answer_id"].present?}
                               .map{|x| x["answer_id"]}
    answers = Answer.find(array_ids).select &:truth?
    count_correct = answers.size
    ids_correct = answers.pluck :id
    ids_incorrect = array_ids.select{|x| ids_correct.exclude?(x)}
    point_collect = count_correct * Settings.User.point
    ids_question = data["question_ids"]
    ids_truth_all_questions = Answer.ids_truth_for_questions ids_question
    {number_correct: count_correct,
     ids_correct: ids_truth_all_questions,
     ids_incorrect: ids_incorrect,
     point_collect: point_collect}
  end
end
