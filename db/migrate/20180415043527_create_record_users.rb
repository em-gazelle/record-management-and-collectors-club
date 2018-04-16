class CreateRecordUsers < ActiveRecord::Migration[5.0]
  def change
    create_join_table :records, :users do |t|
      t.integer :condition
      t.integer :rating
      t.boolean :favorite

      t.index :record_id
      t.index :user_id

      t.timestamps
    end
  end
end