class ChangeFormFormat < ActiveRecord::Migration
  def up
    change_column :players, :form, :float
  end

  def down
    change_column :players, :form, :integer
  end
end
