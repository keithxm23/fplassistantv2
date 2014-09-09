class GameweeksController < ApplicationController

  # GET /gameweeks
  # GET /gameweeks.json
  def fixtures
    @ARS = Gameweek.where("home_team = 'Arsenal' OR away_team = 'Arsenal'").order(:gw_num)

    render "gameweeks/_fixtures", :layout => false
  end

end
