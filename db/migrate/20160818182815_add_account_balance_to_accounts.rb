class AddAccountBalanceToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :acc_balance, :integer, null: false
  end
end
