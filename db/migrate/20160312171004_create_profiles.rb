class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.date :birthday
      t.string :location
      t.string :gender
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
