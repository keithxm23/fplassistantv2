class AddPlayerIdToPerformance < ActiveRecord::Migration
  def change
    add_column :performances, :player_id, :integer
  end
end