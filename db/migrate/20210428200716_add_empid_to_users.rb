class AddEmpidToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :empid, :string
    add_index :users, :empid, unique: true
  end
end
