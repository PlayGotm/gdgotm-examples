extends Control

var _mouse_start: Vector2
var _last_color: int = -1
var _color: int

signal link_copied(address: String)
signal client_connected(did_connect: bool)

func host() -> bool:
	$Spinner.show()
	$Instructions.hide()
	$Address.text = ""
	$CopyLink.hide()
	var peer := await GotmMultiplayer.create_server()
	multiplayer.multiplayer_peer = peer
	
	if peer:
		peer.peer_connected.connect(_player_connected)
		_last_color = (_last_color + 1) % 8
		_set_color(_last_color)
		$Address.text = "Address: " + await GotmMultiplayer.get_address()
		$CopyLink.show()
	
	$Spinner.hide()
	$Instructions.show()
	
	return !!peer


func join(address: String) -> bool:
	$Spinner.show()
	$Instructions.hide()
	$Address.text = ""
	$CopyLink.hide()
	
	var peer := await GotmMultiplayer.create_client(address)
	multiplayer.multiplayer_peer = peer
	
	multiplayer.connected_to_server.connect(func():
		$Address.text = "Address: " + address
		$CopyLink.show()
		$Spinner.hide()
		$Instructions.show()
		client_connected.emit(true)
	, CONNECT_ONE_SHOT)
	multiplayer.connection_failed.connect(func():
		client_connected.emit(false)
	, CONNECT_ONE_SHOT)
	
	return await client_connected


func _player_connected(id):
	_last_color = (_last_color + 1) % 8
	rpc_id(id, "_set_color", _last_color)
	for color in range(8):
		rpc_id(id, "_init_canvas_color", $Canvas.get_used_cells_by_id(0, color, Vector2i(0, 0)), color)


@rpc("any_peer", "call_local") func _init_canvas_color(positions, color):
	for position in positions:
		$Canvas.set_cell(0, position, color, Vector2i(0, 0))


@rpc("any_peer", "call_local") func _set_color(color):
	_color = color


# http://rosettacode.org/wiki/Bitmap/Bresenham%27s_line_algorithm#C
@rpc("any_peer", "call_local") func _rasterize_line(x0: int, y0: int, x1: int, y1: int, color: int) -> void:
	var dx: int = int(abs(x1 - x0))
	var dy: int = int(abs(y1 - y0))
	var sx: int = 1 if x0 < x1 else -1
	var sy: int = 1 if y0 < y1 else -1
	var err: int = (dx if dx > dy else -dy) / 2
	var e2: int
	while true:
		$Canvas.set_cell(0, Vector2i(x0, y0), color, Vector2i(0, 0))
		if x0 == x1 and y0 == y1:
			break
		e2 = err
		if e2 > -dx:
			err -= dy
			x0 += sx
		if e2 < dy:
			err += dx
			y0 += sy


func _on_Background_gui_input(event):
	if $Spinner.visible:
		return
	
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_MASK_LEFT:
			_mouse_start = event.position
	elif event is InputEventMouseMotion:
		if event.button_mask & MOUSE_BUTTON_MASK_LEFT:
			var v0 = _mouse_start / $Canvas.scale
			var v1 = event.position / $Canvas.scale
			var x0: int = int(v0.x)
			var y0: int = int(v0.y)
			var x1: int = int(v1.x)
			var y1: int = int(v1.y)
			rpc("_rasterize_line", x0, y0, x1, y1, _color)
			_mouse_start = event.position


func _on_CloseInstructions_clicked(instance):
	$Instructions.hide()


func _on_copy_link_clicked(instance):
	var address = $Address.text.replace("Address: ", "")
	link_copied.emit(address)
