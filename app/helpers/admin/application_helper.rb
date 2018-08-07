module Admin::ApplicationHelper
  def not_belong_to_exam question_type
    question_type.exam_id.nil?
  end
end
