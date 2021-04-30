class AddEmpIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :emp_id, :string
    add_index :users, :emp_id, unique: true
  end
end
