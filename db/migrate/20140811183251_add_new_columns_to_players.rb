class AddNewColumnsToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :goals_conceded, :integer 
  end
end
