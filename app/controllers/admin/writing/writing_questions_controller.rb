class Admin::Writing::WritingQuestionsController < ApplicationController
  layout "admin/application"
  def index
    @question_type_writing = GetAllQuestionTypeByTopic
                             .call Topic.codes[:writing]
  end
end
