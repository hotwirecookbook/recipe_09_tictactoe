class MovesController < ApplicationController
  def create
    @game = Game.find(params[:game_id])
    Move.make(move_params.merge(game: @game))
  end

  private

  def move_params
    params.require(:move).permit(:position, :player_id)
  end
end
