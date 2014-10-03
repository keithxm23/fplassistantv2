class CreatePerformances < ActiveRecord::Migration
  def change
    create_table :performances do |t|
      t.date :game_date
      t.integer :gameweek
      t.integer :opp_team_id
      t.boolean :at_home
      t.integer :team_goals
      t.integer :opp_team_goals
      t.integer :minutes
      t.integer :goals
      t.integer :assists
      t.integer :clean_sheets
      t.integer :conceded
      t.integer :own_goals
      t.integer :pens_saved
      t.integer :pens_missed
      t.integer :yellows
      t.integer :reds
      t.integer :saves
      t.integer :bonus
      t.integer :esp
      t.integer :bps
      t.integer :net_transfers
      t.float :value
      t.integer :points

      t.timestamps
    end
  end
end
