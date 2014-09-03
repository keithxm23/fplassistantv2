class PlayersController < ApplicationController
  # GET /players
  # GET /players.json
  def index
    @players = Player.where("status != 'u'").order("total_points DESC")

    #TODO Refactor this to use raw select so that we're performing a single query
    @vals = Player.select("MAX(now_cost) as max_cost," \
                          "MIN(now_cost) as min_cost," \
                          "MAX(total_points) as max_ts," \
                          "MIN(total_points) as min_ts," \
                          "MAX(minutes) as max_mins," \
                          "MIN(minutes) as min_mins," \
                          "MAX(form) as max_form," \
                          "MIN(form) as min_form," \
                          "MAX(ea_index) as max_ea_index," \
                          "MIN(ea_index) as min_ea_index," \
                          "MAX(bps) as max_bps," \
                          "MIN(bps) as min_bps," \
                          "MAX(bonus) as max_bonus," \
                          "MIN(bonus) as min_bonus," \
                          "MAX(selected_by_percent) as max_selected_by_percent," \
                          "MIN(selected_by_percent) as min_selected_by_percent," \
                          "MAX(penalties_missed) as max_penalties_missed," \
                          "MIN(penalties_missed) as min_penalties_missed," \
                          "MAX(penalties_saved) as max_penalties_saved," \
                          "MIN(penalties_saved) as min_penalties_saved," \
                          "MAX(own_goals) as max_own_goals," \
                          "MIN(own_goals) as min_own_goals," \
                          "MAX(clean_sheets) as max_clean_sheets," \
                          "MIN(clean_sheets) as min_clean_sheets," \
                          "MAX(saves) as max_saves," \
                          "MIN(saves) as min_saves," \
                          "MAX(goals_conceded) as max_goals_conceded," \
                          "MIN(goals_conceded) as min_goals_conceded," \
                          "MAX(assists) as max_assists," \
                          "MIN(assists) as min_assists," \
                          "MAX(goals_scored) as max_goals_scored," \
                          "MIN(goals_scored) as min_goals_scored," \
                          "MAX(yellow_cards) as max_yellow_cards," \
                          "MIN(yellow_cards) as min_yellow_cards," \
                          "MAX(red_cards) as max_red_cards," \
                          "MIN(red_cards) as min_red_cards," \
                          "MAX(dreamteam_count) as max_dreamteam_count," \
                          "MIN(dreamteam_count) as min_dreamteam_count"
                          )[0]

    jsondata = {}
    jsondata['total'] = "50"
    jsondata['page'] = "1"
    jsondata['records'] = @players.count.to_s
    jsondata['rows'] = @players

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: jsondata }
    end
  end

  def help
  end

  def about
  end

  def contact
  end

end
