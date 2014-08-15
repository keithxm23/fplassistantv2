class RemoveOldColumnsFromPlayers < ActiveRecord::Migration
  def change
    remove_column :players, :last_season_points
    remove_column :players, :squad_number
    remove_column :players, :transfers_balance
    remove_column :players, :news_updated
    remove_column :players, :news_added
    remove_column :players, :event_cost
    remove_column :players, :shirt_image_url
    remove_column :players, :element_type_id
    remove_column :players, :max_cost
    remove_column :players, :selected
    remove_column :players, :min_cost
    remove_column :players, :added
    remove_column :players, :shirt_mobile_image_url
    remove_column :players, :original_cost
    remove_column :players, :news_return
    remove_column :players, :photo_mobile_url
  end
end
