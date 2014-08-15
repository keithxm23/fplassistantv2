class FixColumnNameTransferBalance < ActiveRecord::Migration
  def change
    rename_column :players, :transfer_balance, :transfers_balance
  end
end
