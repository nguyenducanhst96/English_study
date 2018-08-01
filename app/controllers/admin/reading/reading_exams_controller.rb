class Admin::Reading::ReadingExamsController < ApplicationController
  layout "admin/application"

  def index
    @grammar_exams = GetAllExamByTopic.call Topic.codes[:grammar]
    @sign_exams = GetAllExamByTopic.call Topic.codes[:sign]
    @paragraph_exams = GetAllExamByTopic.call Topic.codes[:paragraph]
    @fill_exams = GetAllExamByTopic.call Topic.codes[:fill]
  end
end
