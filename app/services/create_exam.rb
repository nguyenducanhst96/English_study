class CreateExam
  def self.call params_exam
    name = params_exam[:name]
    question_types = QuestionType
                     .get_from_question_ids params_exam[:question_ids]
    Exam.transaction do
      exam = Exam.new name: name, topic_id: Topic.codes[:grammar]
      if exam.save
        question_types.update_all exam_id: exam.id
        exam
      end
    end
  end
end
