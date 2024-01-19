@tool
extends Control

signal selection_changed(text)

@export var allow_empty: bool = true: set = set_allow_empty
@export var selected_index: int = -1: set = set_selected_index


func _ready():
	_init_children()


func set_selected_index(new):
	if new >= get_child_count():
		new = -1
	selected_index = new
	
	for child in get_children():
		child.filled = child.get_index() == selected_index
		
	if not allow_empty and selected_index < 0 and get_child_count() > 0:
		get_child(0).filled = true


func set_allow_empty(new):
	allow_empty = new
	if allow_empty:
		set_selected_index(-1)
	elif get_child_count() > 0:
		_button_clicked(get_child(0))


func add_child(node, legible_unique_name = false):
	super.add_child(node, legible_unique_name)
	_init_children()

func _init_children():
	for i in range(get_child_count()):
		var button = get_child(i)
		if get_child_count() == 1:
			button.group = 0
		elif i == 0:
			button.group = 1
		elif i < get_child_count() - 1:
			button.group = 2
		else:
			button.group = 3
		
		if not button.is_connected("clicked", Callable(self, "_button_clicked")):
			button.connect("clicked", Callable(self, "_button_clicked"))


func _button_clicked(instance):
	if allow_empty:
		instance.filled = !instance.filled
	elif not instance.filled:
		instance.filled = true
	else:
		return
		
	if instance.filled:
		set_selected_index(instance.get_index())
		if not Engine.is_editor_hint():
			emit_signal("selection_changed", instance.text)
	else:
		set_selected_index(-1)
		if not Engine.is_editor_hint():
			emit_signal("selection_changed", null)
