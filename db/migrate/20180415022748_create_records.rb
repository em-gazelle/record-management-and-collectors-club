class CreateRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :records do |t|
      t.string :artist
      t.string :album_title
      t.integer :year

      t.timestamps
    end
  end
end
