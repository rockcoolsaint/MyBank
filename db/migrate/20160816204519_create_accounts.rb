class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :acc_num
      t.string :acc_type
      t.references :customer, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :accounts, :acc_num, unique: true
  end
end
