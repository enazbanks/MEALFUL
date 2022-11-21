class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.date :date
      t.integer :price
      t.integer :status
      t.references :user, null: false, foreign_key: true
      t.references :meals, null: false, foreign_key: true

      t.timestamps
    end
  end
end
