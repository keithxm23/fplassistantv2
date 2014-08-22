class AddGoalColumnsToUpcomingGameweeks < ActiveRecord::Migration
  def change
    add_column :upcoming_gameweeks, :home_goals, :integer
    add_column :upcoming_gameweeks, :away_goals, :integer
  end
end
