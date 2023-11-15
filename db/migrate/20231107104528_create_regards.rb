class CreateRegards < ActiveRecord::Migration[7.0]
  def change
    create_table :regards do |t|
      t.string :name, null: false
      t.references :question, null: false, foreign_key: true
      t.timestamps
    end
  end
end
