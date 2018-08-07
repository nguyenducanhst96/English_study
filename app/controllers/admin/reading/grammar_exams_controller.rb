class Admin::Reading::GrammarExamsController < ApplicationController
  layout "admin/application"

  def new
    @grammar_exam = CreateNextExam.call Topic.codes[:grammar]
    @questions_not_in_exam = (Question.not_belong_to_exam Topic.codes[:grammar])
                             .page(params[:page])
                             .per Settings.Admin.grammar_exams.per_page
  end

  def create
    if CreateExam.call grammar_exam_params
      flash[:success] = t ".flash_success"
      redirect_to admin_reading_reading_exams_path
    else
      flash[:danger] = t ".flash_danger"
      redirect_to new_admin_reading_grammar_exam_path
    end
  end

  private

  def grammar_exam_params
    exam = params.require(:exam)
    {name: exam[:name], question_ids: exam[:question_ids]}
  end
end
