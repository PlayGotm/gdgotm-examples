extends Node
#warnings_disable


const OPTIONS = {
	"lobby": {
		"path": "res://examples/lobby/Lobby.tscn",
		"name": "Lobby",
		"description": "Discover multiplayer sessions hosted by other players."
	},
	"multiplayer": {
		"path": "res://examples/multiplayer/Multiplayer.tscn",
		"name": "Multiplayer",
		"description": "Connect players in peer-to-peer multiplayer sessions without port-forwarding."
	}
}


func _ready():
	Gotm.project_key = "authenticators/ccG2PZyIak36FjT2COCE"

	for option_key in OPTIONS:
		if OS.has_feature("option_" + option_key):
			get_tree().change_scene(OPTIONS[option_key].path)
			return
	
	var y = 0
	for option_key in OPTIONS:
		var button := _create_option_button(OPTIONS[option_key])
		button.position.y += y
		y += button.size.y * 1.1	
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
	label.vertical_alignment = VERTICAL_ALIGNMENT_TOP
	label.offset_top = label.size.y * 0.5
	description.text = option.description

	return button
	



func _on_Button_clicked(button: Control):
	get_tree().change_scene_to_file(OPTIONS[button.name].path)
