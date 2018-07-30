class AddCodeToTopics < ActiveRecord::Migration[5.2]
  def change
    add_column :topics, :code, :integer
  end
end
