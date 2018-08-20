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
end
