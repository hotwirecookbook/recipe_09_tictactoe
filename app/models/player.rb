class Player < ApplicationRecord
  belongs_to :game
  belongs_to :user

  has_many :moves, dependent: :destroy
  has_many :games_won, foreign_key: :winner_id, class_name: 'Game'
  
  validates :user, uniqueness: { scope: :game }

  after_create_commit :assign_symbol

  enum symbol: {
    cross: 'cross',
    circle: 'circle'
  }

  private

  def assign_symbol
    if game.players.count == 1
      update(symbol: :cross)
    else
      update(symbol: :circle)
    end  
  end
end
