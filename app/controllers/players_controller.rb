class PlayersController < ApplicationController
  # GET /players
  # GET /players.json
  def index
    @players = Player.where("status != 'u'")

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
