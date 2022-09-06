extends Control

const Utility := preload("res://examples/lobby/fetch/Utility.gd")


var _lobby


func set_lobby(lobby: GotmLobby):
	_lobby = lobby
	$PeerCount/Value.text = str(lobby.get_property("player_count"))
	$Difficulty/Value.text = Utility.difficulty_to_string(lobby.get_property("difficulty"))
	$Map/Value.text = lobby.get_property("map")
	$Name.text = lobby.name


func _on_LobbyTemplate_mouse_entered():
	modulate = Color.white * 1.05


func _on_LobbyTemplate_mouse_exited():
	modulate = Color.white
