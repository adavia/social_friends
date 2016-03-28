class AddPrimaryToAttachments < ActiveRecord::Migration
  def change
    add_column :attachments, :primary, :boolean, default: false
  end
end
