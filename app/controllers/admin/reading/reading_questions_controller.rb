class Admin::Reading::ReadingQuestionsController < ApplicationController
  layout "admin/application"
  def index
    @question_type_grammar = GetAllQuestionTypeByTopic
                             .call Topic.codes[:grammar]
    @question_type_sign = GetAllQuestionTypeByTopic
                          .call Topic.codes[:sign]
    @question_type_paragraph = GetAllQuestionTypeByTopic
                               .call Topic.codes[:paragraph]
    @question_type_filling = GetAllQuestionTypeByTopic
                             .call Topic.codes[:fill]
  end
end
