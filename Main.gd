extends Node
#warnings_disable


const OPTIONS = {
	"lobby_fetch": {
		"path": "res://examples/lobby/fetch/LobbyFetch.tscn",
		"name": "Lobby browser",
		"description": "Browse lobbies using flexible filters and sorting."
	},
	"lobby_host_and_join": {
		"path": "res://examples/lobby/host_and_join/LobbyHostAndJoin.tscn",
		"name": "Lobby list",
		"description": "Discover multiplayer sessions hosted by other players."
	},
	"multiplayer": {
		"path": "res://examples/multiplayer/Multiplayer.tscn",
		"name": "Multiplayer",
		"description": "Connect players in peer-to-peer multiplayer sessions without port-forwarding."
	},
	"tests": {
		"path": "res://tests/Tests.tscn",
		"name": "GDGotm tests",
		"description": "Run GDGotm's integration tests.",
	}
}


func _ready():
	for option_key in OPTIONS:
		if OS.has_feature("option_" + option_key):
			get_tree().change_scene(OPTIONS[option_key].path)
			return
			
	
	var y = 0
	for option_key in OPTIONS:
		var button := _create_option_button(OPTIONS[option_key])
		button.rect_position.y += y
		y += button.rect_size.y * 1.1	
		button.name = option_key
		add_child(button)
	return

func _create_option_button(option) -> Control:
	var button_template := $Button
	var button: Control = button_template.duplicate()
	button.visible = true
	button.text = option.name
	var description: Label = button.get_node("Description")
	var label: Label = button.get_node("Label")
	label.valign = Label.VALIGN_TOP
	label.margin_top = label.rect_size.y * 0.5
	description.text = option.description

	return button
	



func _on_Button_clicked(button: Control):
	get_tree().change_scene(OPTIONS[button.name].path)
