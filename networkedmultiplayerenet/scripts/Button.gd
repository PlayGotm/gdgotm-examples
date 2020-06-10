tool
extends Panel

signal clicked()

export(String) var text = "Text" setget set_text



func set_text(new_text):
	text = new_text
	$Label.text = text

func _on_Button_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed:
				modulate = Color.white * 0.7
		else:
			_on_Button_mouse_entered()
			emit_signal("clicked")


func _on_Button_mouse_entered():
	modulate = Color.white * 0.95


func _on_Button_mouse_exited():
	modulate = Color.white
