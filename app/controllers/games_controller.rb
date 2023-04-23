class GamesController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
    @player = @game.players.find_by(user: current_user)
  end

  def create
    @game = Game.create
    @game.players << Player.create(user: current_user)

    redirect_to @game
  end
end
