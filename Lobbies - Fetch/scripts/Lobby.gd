extends Control

signal selected(lobby)

var _lobby

func get_difficulty_string(difficulty):
	match int(difficulty):
		0:
			return "easy"
		1:
			return "medium"
		2:
			return "hard"
		_:
			return "???"
	

func set_lobby(lobby):
	_lobby = lobby
	$PeerCount/Value.text = str(lobby.get_property("player_count"))
	$Difficulty/Value.text = str(get_difficulty_string(lobby.get_property("difficulty")))
	$Map/Value.text = lobby.get_property("map")
	$Name.text = lobby.name




func _on_LobbyTemplate_mouse_entered():
	modulate = Color.white * 1.05


func _on_LobbyTemplate_mouse_exited():
	modulate = Color.white


func _on_LobbyTemplate_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			modulate = Color.white * 1.3
		else:
			_on_LobbyTemplate_mouse_entered()
			emit_signal("selected", _lobby)
