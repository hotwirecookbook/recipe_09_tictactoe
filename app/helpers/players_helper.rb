module PlayersHelper
  def symbol_tag(player)
    render partial: "players/symbol", locals: { player: player }
  end
end
