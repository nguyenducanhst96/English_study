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
    data = CreateInfoAnswers.call ActiveSupport::JSON.decode request.body.read
    render json: {
      number_correct: data[:number_correct],
      ids_correct: data[:ids_correct],
      ids_incorrect: data[:ids_incorrect],
      point_collect: data[:point_collect]
    }
  end
end
