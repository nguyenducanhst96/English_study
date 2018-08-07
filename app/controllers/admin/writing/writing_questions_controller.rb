class Admin::Writing::WritingQuestionsController < ApplicationController
  layout "admin/application"
  before_action :find_question, only: %i(edit update)
  def index
    @question_type_writing = GetAllQuestionTypeByTopic
                             .call Topic.codes[:writing]
  end

  def new
    @question = Question.new
    @question.answers.new
  end

  def create
    question_type = QuestionType.new topic_id: Topic.codes[:writing]
    @question = question_type.questions.build question_params
    if @question.save
      flash[:success] = t ".flash_success"
      redirect_to admin_writing_writing_questions_url
    else
      render :new
    end
  end

  def edit; end

  def update
    if @question.update_attributes question_params
      flash[:success] = ".flash_success"
      redirect_to admin_writing_writing_questions_url
    else
      render :edit
    end
  end

  private

  def question_params
    params.require(:question).permit :title,
      answers_attributes: [:id, :content, :truth]
  end

  def find_question
    @question = Question.find_by id: params[:id]
    return if @question
    flash[:notice] = t "admin.writing.writing_questions.update.flash_notice"
    redirect_to admin_writing_writing_questions_url
  end
end
