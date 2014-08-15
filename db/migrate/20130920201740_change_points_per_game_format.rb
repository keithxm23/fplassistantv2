class ChangePointsPerGameFormat < ActiveRecord::Migration
  def up
    change_column :players, :points_per_game, :float
  end

  def down
    change_column :players, :points_per_game, :integer
  end
end
