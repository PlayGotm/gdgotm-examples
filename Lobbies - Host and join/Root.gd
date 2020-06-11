extends Control


func _on_Gotm_lobby_changed():
	if not Gotm.lobby:
		$Lobbies.show()
		$Game.hide()


func _ready():
	Gotm.connect("lobby_changed", self, "_on_Gotm_lobby_changed")
	$Game.hide()

func _on_Lobbies_join_pressed(lobby: GotmLobby):
	$Lobbies.hide()
	$Game.show()
	
	$Game.join()
	var success = yield(lobby.join(), "completed")
	if not success:
		push_error("Failed to connect to lobby '" + lobby.name + "'!")
		$Lobbies.show()
		$Game.hide()


func _on_Lobbies_host_pressed(name: String):
	$Lobbies.hide()
	$Game.show()
	
	Gotm.host_lobby(false)
	Gotm.lobby.hidden = false
	Gotm.lobby.name = name
	$Game.host()
