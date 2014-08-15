class AddSavesToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :saves, :integer
  end
end
