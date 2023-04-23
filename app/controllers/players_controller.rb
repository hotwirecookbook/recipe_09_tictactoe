class PlayersController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @player = Player.new
    
    @game = Game.find(params[:game_id])
    @player.game = @game
    @player.user = current_user

    if @player.save
      redirect_to @game
    else
      redirect_to root_path, alert: "Try again"
    end
  end
end
