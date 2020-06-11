extends Panel

signal text_changed(new_text)



func _on_Input_text_changed(new_text):
	emit_signal("text_changed", new_text)
