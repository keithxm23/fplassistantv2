class CreateTeamTable < ActiveRecord::Migration
  def change
    create_table :team_tables do |t|
      t.integer :sqwk_club_id
      t.integer :fpl_team_id

      t.string :sqwk_name
      t.string :sqwk_full_name
      t.string :fpl_acrynm_name
      t.string :fpl_team_name
      t.string :sqwk_club_stats_urls

      t.timestamps
    end
  end
end
