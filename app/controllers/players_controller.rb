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

  # GET /players/1
  # GET /players/1.json
  def show
    @player = Player.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @player }
    end
  end
  
  def filter    
    respond_to do |format|
      format.html 
    end
  end

  def howto
  end

end
