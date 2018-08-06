class Admin::Writing::WritingQuestionsController < ApplicationController
  layout "admin/application"
  def index
    @question_type_writing = GetAllQuestionTypeByTopic
                             .call Topic.codes[:writing]
    @question = Question.new
    @question.answers.new
  end

  def create
    question_type = QuestionType.new topic_id: Topic.codes[:writing]
    @question = question_type.questions.build question_params
    return unless @question.save
    flash[:success] = t ".flash_success"
    redirect_to admin_writing_writing_questions_url
  end

  private

  def question_params
    params.require(:question).permit :title,
      answers_attributes: [:content, :truth]
  end
end
