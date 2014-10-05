class AddTeamsToPerformances < ActiveRecord::Migration
  def change
    add_column :performances, :team_name, :string
    add_column :performances, :opp_team_name, :string
  end
end
