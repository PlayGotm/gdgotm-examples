tool
extends Panel

signal clicked(instance)

export(String) var text = "Text" setget set_text
export(bool) var filled = false setget set_filled
export(Texture) var texture = null setget set_texture
export(int, "32px", "64px") var size = 0 setget set_size

export(StyleBox) var unfilled_stylebox = preload("Unfilled.tres") setget set_unfilled_stylebox
export(StyleBox) var filled_stylebox = preload("Filled.tres") setget set_filled_stylebox

func _ready():
	call_deferred("_update_label_size")


func set_size(new_size):
	size = new_size
	var font
	if new_size == 0:
		font = preload("res://resources/fonts/RobotoLight-32px.tres")
	else:
		font = preload("res://resources/fonts/RobotoLight-64px.tres")
	
	$Label.set("custom_fonts/font", font)
	set_filled(filled)
	call_deferred("_update_label_size")


func _update_label_size():
	$Label.rect_size = rect_size
	$Label.rect_pivot_offset = rect_size / 2.0


func set_text(new_text):
	text = new_text
	$Label.text = text

func set_texture(new_texture):
	texture = new_texture
	if texture:
		$Texture.texture = texture
		$Texture.show()
		$Label.hide()
	else:
		$Texture.hide()
		$Label.show()
	

func set_filled(new_filled):
	filled = new_filled

	
	if filled:
		$Label.modulate = Color.white
		$Texture.modulate = Color.white
		set("custom_styles/panel", filled_stylebox)
	else:
		$Label.modulate = Color.black
		$Texture.modulate = Color.black
		set("custom_styles/panel", unfilled_stylebox)
		


func set_unfilled_stylebox(new_box):
	unfilled_stylebox = new_box
	set_filled(filled)

func set_filled_stylebox(new_box):
	filled_stylebox = new_box
	set_filled(filled)



func _on_Button_mouse_entered():
	if filled:
		modulate = Color.white * 1.05
	else:
		modulate = Color.white * 0.95
		


func _on_Button_mouse_exited():
	modulate = Color.white

func _on_Button_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			if filled:
				modulate = Color.white * 1.3
			else:
				modulate = Color.white * 0.7
		else:
			_on_Button_mouse_entered()
			emit_signal("clicked", self)




func _on_Button_resized():
	_update_label_size()
