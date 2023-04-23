class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :players
  has_many :games, through: :players

  def is_playing_game?(game)
    Player.exists?(user: self, game: game)
  end
end
