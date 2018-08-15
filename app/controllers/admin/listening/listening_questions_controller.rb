class Admin::Listening::ListeningQuestionsController < ApplicationController
  layout "admin/application"
  before_action :find_question_type, only: %i(destroy)
  before_action :not_belong_to_exam, only: %i(destroy)

  def index
    @question_type_picture = GetAllQuestionTypeByTopic
                             .call Topic.codes[:picture]
    @question_type_conversation = GetAllQuestionTypeByTopic
                                  .call Topic.codes[:conversation]
  end

  def destroy
    @question_type = QuestionType.find_by id: params[:id]
    @question_type.destroy
    flash[:success] = t ".flash"
    redirect_to request.referrer || root_url
  end

  private

  def find_question_type
    @question_type = QuestionType.find_by id: params[:id]
    return if @question_type
    flash[:notice] = t "admin.writing.writing_questions.update.flash_notice"
    redirect_to admin_listening_listening_questions_url
  end

  def not_belong_to_exam
    @question_type.exam_id.nil?
  end
end
