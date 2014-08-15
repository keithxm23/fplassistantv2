class AddSummaryColumnToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :summary, :string
  end
end
