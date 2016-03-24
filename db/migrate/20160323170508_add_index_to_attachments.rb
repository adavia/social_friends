class AddIndexToAttachments < ActiveRecord::Migration
  def change
    add_index :attachments, :attachable_type
  end
end
