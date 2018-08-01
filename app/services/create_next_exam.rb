class CreateNextExam
  def self.call code
    exams = GetAllExamByTopic.call code
    exams.each_with_index do |exam, index|
      number_exam = exam.number_name_exam
      number_next_exam = number_exam + 1
      name_next_exam = exam.init_name_exam number_next_exam
      return Exam.new(name: name_next_exam) unless index < (exams.size - 1)
      if index < (exams.size - 1)
        exam = Exam.new(name: name_next_exam)
        return exam if number_next_exam != exams[index + 1].number_name_exam
      end
    end
  end
end
