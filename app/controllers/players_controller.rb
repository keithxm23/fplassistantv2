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
                          "MIN(selected_by_percent) as min_selected_by_percent"
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

  def changelog
  end

end
