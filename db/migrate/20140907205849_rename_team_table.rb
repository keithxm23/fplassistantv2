class RenameTeamTable < ActiveRecord::Migration
  def change
      rename_table :team_tables, :teams
  end
end
