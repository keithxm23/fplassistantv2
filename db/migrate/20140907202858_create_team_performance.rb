class CreateTeamPerformance < ActiveRecord::Migration
  def change
    create_table :team_performances do |t|
      t.integer :sqwk_club_id
      t.float :def_avg
      t.float :att_avg
      t.float :pos_avg
      t.float :tot_avg

    end
  end
end
