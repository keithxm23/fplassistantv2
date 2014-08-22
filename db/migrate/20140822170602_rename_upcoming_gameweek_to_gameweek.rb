class RenameUpcomingGameweekToGameweek < ActiveRecord::Migration
  def change
    rename_table :upcoming_gameweeks, :gameweeks
  end
end
