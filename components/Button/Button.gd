@tool
extends Panel

signal clicked(instance)

@export var text: String = "Text": set = set_text
@export var filled: bool = false: set = set_filled
@export var texture: Texture2D = null: set = set_texture
@export var font_size := 0: set = _set_font_size
@export var group = 0: set = set_group

var _unfilled_stylebox = preload("Unfilled.tres")
var _filled_stylebox = preload("Filled.tres")

func _ready():
	call_deferred("_update_label_size")


func set_group(new_group):
	group = new_group
	if group == 0:
		_unfilled_stylebox = preload("Unfilled.tres")
		_filled_stylebox = preload("Filled.tres")
	elif group == 1:
		_unfilled_stylebox = preload("UnfilledLeft.tres")
		_filled_stylebox = preload("FilledLeft.tres")
	elif group == 2:
		_unfilled_stylebox = preload("UnfilledCenter.tres")
		_filled_stylebox = preload("FilledCenter.tres")
	else:
		_unfilled_stylebox = preload("UnfilledRight.tres")
		_filled_stylebox = preload("FilledRight.tres")
	set_filled(filled)

func _set_font_size(new_size):
	font_size = new_size

	var font
	if font_size == 0:
		font = preload("res://resources/fonts/RobotoLight-32px.tres")
	else:
		font = preload("res://resources/fonts/RobotoLight-64px.tres")
	
	$Label.set("theme_override_fonts/font", font)
	set_filled(filled)
	call_deferred("_update_label_size")


func _update_label_size():
	$Label.set_deferred("size", size)
	$Label.pivot_offset = size / 2.0


func set_text(new_text):
	text = new_text
	$Label.text = text

func set_texture(new_texture):
	texture = new_texture
	if texture:
		$Texture2D.texture = texture
		$Texture2D.show()
		$Label.hide()
	else:
		$Texture2D.hide()
		$Label.show()
	

func set_filled(new_filled):
	filled = new_filled

	
	if filled:
		$Label.modulate = Color.WHITE
		$Texture2D.modulate = Color.WHITE
		set("theme_override_styles/panel", _filled_stylebox)
	else:
		$Label.modulate = Color.BLACK
		$Texture2D.modulate = Color.BLACK
		set("theme_override_styles/panel", _unfilled_stylebox)
		


func _on_Button_mouse_entered():
	if filled:
		modulate = Color.WHITE * 1.05
	else:
		modulate = Color.WHITE * 0.95
		


func _on_Button_mouse_exited():
	modulate = Color.WHITE

func _on_Button_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			if filled:
				modulate = Color.WHITE * 1.3
			else:
				modulate = Color.WHITE * 0.7
		else:
			_on_Button_mouse_entered()
			emit_signal("clicked", self)




func _on_Button_resized():
	_update_label_size()
