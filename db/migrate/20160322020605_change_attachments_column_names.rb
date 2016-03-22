class ChangeAttachmentsColumnNames < ActiveRecord::Migration
  def change
    rename_column :attachments, :post_id, :attachable_id
    add_column :attachments, :attachable_type, :string
  end
end
