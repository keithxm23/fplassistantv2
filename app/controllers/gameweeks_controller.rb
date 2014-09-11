class GameweeksController < ApplicationController

  # GET /gameweeks
  # GET /gameweeks.json
  def fixtures
    gw_data = Gameweek.all.order(:gw_num)
    team_data = Team.includes(:team_performance).all.order(:fpl_team_name)
    @teams = {}

    @fixtures = {}
    team_data.each do |t|
      tm_name = t.fpl_team_name
      @teams[tm_name] = t

      fixs = []
      gw_data.each do |gw|
        if [gw.home_team, gw.away_team].include? tm_name
          if gw.home_team == tm_name
            fixs << {'vs' => gw.away_team, 'at' => 'H'}
          else
            fixs << {'vs' => gw.home_team, 'at' => 'A'}
          end
        end
      end
      @fixtures[tm_name] = fixs
    end

    @curr_gw = Gameweek.where("home_goals is  null").minimum(:gw_num)
    
    @short_name = {
      "Arsenal"=>"ARS",
      "Crystal Palace"=>"CRY",
      "Everton"=>"EVE",
      "Leicester"=>"LEI",
      "Spurs"=>"TOT",
      "Southampton"=>"SOU",
      "Chelsea"=>"CHE",
      "Man City"=>"MCI",
      "Man Utd"=>"MUN",
      "Liverpool"=>"LIV",
      "Swansea"=>"SWA",
      "Newcastle"=>"NEW",
      "QPR"=>"QPR",
      "Stoke"=>"STK",
      "Sunderland"=>"SUN",
      "West Ham"=>"WHU",
      "Aston Villa"=>"AVL",
      "West Brom"=>"WBA",
      "Burnley"=>"BUR",
      "Hull"=>"HUL"
    }

    @vals = TeamPerformance.select("MAX(tot_avg) as max_tot," \
                                    "MIN(tot_avg) as min_tot," \
                                    "MAX(att_avg) as max_att," \
                                    "MIN(att_avg) as min_att," \
                                    "MAX(pos_avg) as max_pos," \
                                    "MIN(pos_avg) as min_pos," \
                                    "MAX(def_avg) as max_def," \
                                    "MIN(def_avg) as min_def"
                                    )[0]

    render "gameweeks/_fixtures", :layout => false
  end

end
