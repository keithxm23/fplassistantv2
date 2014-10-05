class PerformancesController < ApplicationController

  def show
    @performances = Player.find(params[:id]).performances

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @performances }
    end
  end

end
