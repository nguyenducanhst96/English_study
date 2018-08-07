class Admin::Listening::ConversationQuestionsController < ApplicationController
  layout "admin/application"

  def new
    @question_type = QuestionType.new topic_id: Topic.codes[:conversation]
    Settings.Admin.conversation_question.num_question
            .times{@question_type.questions.build}
    @question_type.questions.each do |question|
      Settings.Admin.conversation_question.num_answer
              .times{question.answers.build}
    end
  end

  def create
    @question_type = QuestionType.new question_type_params
    @question_type.topic_id = Topic.codes[:conversation]
    if @question_type.save
      flash[:success] = t ".flash_success"
      redirect_to admin_listening_listening_questions_url
    else
      render :new
    end
  end

  private

  def question_type_params
    params.require(:question_type).permit :content,
      questions_attributes: [:id, :title,
      answers_attributes: [:id, :content, :truth]]
  end

  def find_question
    @question = Question.find_by id: params[:id]
    return if @question
    flash[:notice] = t "admin.writing.writing_questions.update.flash_notice"
    redirect_to admin_writing_writing_questions_url
  end
end
