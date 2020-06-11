extends Control


onready var _fetch = GotmLobbyFetch.new()


func _ready():
	$List/LobbyEntry.hide()
	_refresh()
	


func _on_LobbyEntry_selected(lobby):
	var success = yield(lobby.join(), "completed")
	if not success:
		push_error("Failed to connect to lobby '" + lobby.name + "'!")


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
	Gotm.host_lobby()
	Gotm.lobby.hidden = false
	Gotm.lobby.name = $Host/Name.get_text()