class AddRedCardsToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :red_cards, :integer
  end
end
