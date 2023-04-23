class Game < ApplicationRecord
  belongs_to :winner, class_name: 'Player', optional: true
  has_many :moves, dependent: :destroy
  has_many :players
  has_many :users, through: :players

  def over?
    winner.present? || moves.count == 9
  end

  def move_at_position(position)
    moves.find_by(position: position)
  end

  def has_move_at_position?(position)
    moves.exists?(position: position)
  end
end
