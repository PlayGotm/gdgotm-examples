extends Control


func _on_Gotm_lobby_changed():
	if Gotm.lobby:
		$Lobbies.hide()
		$Game.show()
		if Gotm.lobby.is_host():
			$Game.host()
		else:
			$Game.join()
	else:
		$Lobbies.show()
		$Game.hide()

func _ready():
	Gotm.connect("lobby_changed", self, "_on_Gotm_lobby_changed")
	$Game.hide()