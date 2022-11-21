class ChangePriceToFloat < ActiveRecord::Migration[7.0]
  def change
    change_column :meals, :price, :float
  end
end
