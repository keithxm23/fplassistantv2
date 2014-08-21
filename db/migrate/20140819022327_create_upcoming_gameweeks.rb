class CreateUpcomingGameweeks < ActiveRecord::Migration
  def change
    create_table :upcoming_gameweeks do |t|
      t.integer :gw_num
      t.string :home_team
      t.string :away_team
      t.datetime :at

      t.timestamps
    end
  end
end
