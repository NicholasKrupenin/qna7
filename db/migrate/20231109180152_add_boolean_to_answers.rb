class AddBooleanToAnswers < ActiveRecord::Migration[7.0]
  def change
    add_column :answers, :reward, :boolean, default: false, null: false
  end
end
