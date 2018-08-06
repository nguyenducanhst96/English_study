class GetAllQuestionTypeByTopic
  def self.call code
    topic = Topic.find_by code: code
    return unless topic.present?
    topic.question_types
  end
end
