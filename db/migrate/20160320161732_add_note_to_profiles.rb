class AddNoteToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :note, :text
  end
end
