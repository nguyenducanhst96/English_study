class ReadingController < ApplicationController
  def index; end

  def show
    @code_topic = params[:id]
  end

  def exams_by_topic
    data = ActiveSupport::JSON.decode request.body.read
    @exams = GetAllExamByTopic.call data["id"]
    @exam_paginate = Kaminari.paginate_array(@exams)
                             .page(data["page"]).per data["per"]
    render json: {
      data: @exam_paginate,
      count: @exams.size
    }
  end

  def work_space
    @id_exam = params[:id]
  end

  def exam_detail
    data = ActiveSupport::JSON.decode request.body.read
    id = data["id"]
    @questions = Exam.find(id).questions
    exam = Exam.find_by id: id
    content = exam.question_types.first.content
    render json: {
      questions: @questions.as_json(include: [:answers]),
      code_topic: exam.topic_id,
      content: content
    }
  end

  def check_answer
    data = ActiveSupport::JSON.decode request.body.read
    array_ids = get_array_id data
    answers = Answer.find(array_ids).select(&:truth?)
    count_correct = answers.size
    ids_correct = answers.pluck(:id)
    ids_incorrect = array_ids.select{|x| ids_correct.exclude?(x)}
    point_collect = count_correct * 10
    ids_question = data["question_ids"]
    ids_truth_all_questions = GetIdsTruth.call ids_question
    render json: {
      number_correct: count_correct,
      ids_correct: ids_truth_all_questions,
      ids_incorrect: ids_incorrect,
      point_collect: point_collect
    }
  end

  private

  def get_array_id data
    data["answers"].select{|x| x["answer_id"].present?}
                   .map{|x| x["answer_id"]}
  end
end
