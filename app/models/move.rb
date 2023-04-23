class Move < ApplicationRecord
  belongs_to :game
  belongs_to :player

  validates :position, presence: true, inclusion: { in: 0..8 }
  validates :move_number, presence: true, inclusion: { in: 0..8 }, uniqueness: { scope: :game_id }

  after_create_commit :broadcast_move

  WINNING_COMBINATIONS = [ 
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8], 
    [6,4,2]
  ].freeze

  def self.make(params)
    transaction do
      move = create!(params)
      move.increment!(:move_number)
    end
  end

  def broadcast_move
    if winning?
      game.update(winner: player)

      broadcast_update_to game,
        target: "game_#{game.id}",
        partial: "games/winner",
        locals: { player: player }
    elsif last?
      broadcast_update_to game,
        target: "game_#{game.id}",
        partial: "tic_tac_toe_games/draw"
    else
      broadcast_replace_to game,
        target: "position_#{position}",
        partial: "players/symbol",
        locals: {
          player: player
        }
    end
  end

  def winning?
    WINNING_COMBINATIONS.any? do |combination|
      combination.all? do |position|
        game.move_at_position(position).try(:player) == player
      end
    end
  end
  
  def last?
    move_number == 8
  end
end
