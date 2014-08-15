class AddPhotoToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :photo, :text
  end
end
