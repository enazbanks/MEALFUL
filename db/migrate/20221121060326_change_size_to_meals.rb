class ChangeSizeToMeals < ActiveRecord::Migration[7.0]
  def change
    rename_column :meals, :size, :min_size
    add_column :meals, :max_size, :integer
  end
end
