class AddSuggestedCommentToDialogue < ActiveRecord::Migration
  def self.up
    add_column :dialogue, :suggested_comment, :text
    add_column :dialogue, :message, :text, :null => false
  end

  def self.down
    remove_column :dialogue, :message
    remove_column :dialogue, :suggested_comment
  end
end
