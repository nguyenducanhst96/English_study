class Admin::Listening::ListeningExamsController < ApplicationController
  layout "admin/application"

  def index
    @picture_exams = GetAllExamByTopic.call Topic.codes[:picture]
    @conversation_exams = GetAllExamByTopic.call Topic.codes[:conversation]
  end
end
