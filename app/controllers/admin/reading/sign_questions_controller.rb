class Admin::Reading::SignQuestionsController < ApplicationController
  layout "admin/application"
  before_action :find_question, except: %i(new create)
  before_action :not_belong_to_exam, only: %i(destroy)
  before_action :validate_create, only: %i(create)
  before_action :validate_update, only: %i(update)

  def new
    @question = Question.new
    Settings.Admin.sign_question.num_answer
            .times{@question.answers.new}
  end

  def create
    question_type = QuestionType.new topic_id: Topic.codes[:sign]
    @question = question_type.questions.build question_params
    if @question.save
      flash[:success] = t ".flash_success"
      redirect_to admin_reading_reading_questions_url
    else
      render :new
    end
  end

  def edit; end

  def update
    if @question.update_attributes question_params
      flash[:success] = t ".flash_success"
      redirect_to admin_reading_reading_questions_url
    else
      render :edit
    end
  end

  def destroy
    if @question.question_type&.destroy
      flash[:success] = t ".flash"
    else
      flash[:danger] = t ".flash_danger"
    end
    redirect_to request.referrer || root_url
  end

  private

  def question_params
    params.require(:question).permit :picture,
      answers_attributes: [:id, :content, :truth]
  end

  def find_question
    @question = Question.find_by id: params[:id]
    return if @question
    flash[:notice] = t "admin.writing.writing_questions.update.flash_notice"
    redirect_to admin_writing_writing_questions_url
  end

  def not_belong_to_exam
    @question.question_type.exam_id.nil?
  end

  def validate_create
    return if params[:question][:picture].present?
    flash[:danger] = t ".flash"
    redirect_to new_admin_reading_sign_question_url
  end

  def validate_update
    return if params[:question][:picture].present?
    flash[:danger] = t ".flash"
    redirect_to edit_admin_reading_sign_question_url
  end
end
