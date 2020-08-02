class CreatePlans < ActiveRecord::Migration[6.0]
  def change
    create_table :plans do |t|
      t.integer :amount
      t.string :product_id

      t.timestamps
    end
  end
end
