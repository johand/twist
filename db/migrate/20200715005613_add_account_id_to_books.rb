class AddAccountIdToBooks < ActiveRecord::Migration[6.0]
  def change
    add_reference :books, :account, null: false, foreign_key: true
  end
end
