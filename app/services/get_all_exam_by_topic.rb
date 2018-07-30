class GetAllExamByTopic
  def self.call code
    topic = Topic.find_by code: code
    return unless topic.present?
    topic.exams
  end
end
