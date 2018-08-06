class Admin::Listening::ListeningQuestionsController < ApplicationController
  layout "admin/application"
  def index
    @question_type_picture = GetAllQuestionTypeByTopic
                             .call Topic.codes[:picture]
    @question_type_conversation = GetAllQuestionTypeByTopic
                                  .call Topic.codes[:conversation]
  end
end
