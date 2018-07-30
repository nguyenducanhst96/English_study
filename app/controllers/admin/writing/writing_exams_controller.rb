class Admin::Writing::WritingExamsController < ApplicationController
  layout "admin/application"

  def index
    @writing_exams = GetAllExamByTopic.call Topic.codes[:writing]
  end
end
