class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :players, :last_name, :second_name
  end
end
