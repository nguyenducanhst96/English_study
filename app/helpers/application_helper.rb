module ApplicationHelper
  def option value
    option = {"A" => 0, "B" => 1, "C" => 2, "D" => 3}
    option.key value
  end
end
