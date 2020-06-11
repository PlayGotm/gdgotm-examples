extends Control

signal join_pressed(lobby)
signal host_pressed(name)

onready var _fetch = GotmLobbyFetch.new()


func _ready():
	$List/LobbyEntry.hide()
	_refresh()
	


func _on_LobbyEntry_selected(lobby):
	emit_signal("join_pressed", lobby)



func _refresh():
	$List/Spinner.show()
	for child in $List/Entries.get_children():
		child.queue_free()
	
	var lobbies = yield(_fetch.first(5), "completed")
	
	for i in range(lobbies.size()):
		var lobby = lobbies[i]
		var node = $List/LobbyEntry.duplicate()
		node.show()
		$List/Entries.add_child(node)
		node.set_lobby(lobby)
		node.rect_position.y += i * 80
	
	$List/Spinner.hide()


func _on_Refresh_clicked(instance):
	_refresh()


func _on_Host_clicked(instance):
	emit_signal("host_pressed", $Host/Name.get_text())
