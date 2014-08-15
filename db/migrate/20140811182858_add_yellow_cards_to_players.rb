class AddYellowCardsToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :yellow_cards, :integer 
  end
end
