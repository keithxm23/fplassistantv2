class UpdateAllColumns < ActiveRecord::Migration
  def change 
    add_column :players, :chance_of_playing_this_round, :float
    add_column :players, :chance_of_playing_next_round, :float
    add_column :players, :value_form, :float
    add_column :players, :value_season, :float
    add_column :players, :cost_change_start, :float
    add_column :players, :cost_change_event, :float
    add_column :players, :cost_change_start_fall, :float
    add_column :players, :cost_change_event_fall, :float
    add_column :players, :dreamteam_count, :integer
    add_column :players, :selected_by_percent, :float
    add_column :players, :ep_this, :float
    add_column :players, :ep_next, :float
    add_column :players, :special, :boolean
    add_column :players, :minutes, :integer
    add_column :players, :goals_scored, :integer
    add_column :players, :assists, :integer
    add_column :players, :clean_sheets, :integer
    add_column :players, :own_goals, :integer
    add_column :players, :penalties_saved, :integer
    add_column :players, :penalties_missed, :integer
    add_column :players, :bonus, :integer
    add_column :players, :ea_index, :integer
    add_column :players, :bps, :integer
    add_column :players, :element_type, :integer
    add_column :players, :team, :integer
  end
end
