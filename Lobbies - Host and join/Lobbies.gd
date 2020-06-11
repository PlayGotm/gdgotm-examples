extends Control


onready var _fetch = GotmLobbyFetch.new()


func add_test_lobby(name):
	var lobby = GotmDebug.add_lobby()
	lobby.hidden = false
	lobby.name = name


func add_test_lobbies():
	GotmDebug.clear_lobbies()
	add_test_lobby("Fun only!")
	add_test_lobby("Yoshi's")
	add_test_lobby("-= 1337 Battleground =-")
	add_test_lobby("[Knives only]")
	add_test_lobby("Why can't I hold all these lobbies")
	
func _ready():
	$List/LobbyEntry.hide()
	
	#if not Gotm.is_live():
	#	add_test_lobbies()
	
	_refresh()
	


func _on_LobbyEntry_selected(lobby):
	var success = yield(lobby.join(), "completed")
	if not success:
		push_error("Failed to connect to lobby '" + lobby.name + "'!")


func _refresh():
	$List/Spinner.show()
	for child in $List/Entries.get_children():
		child.queue_free()
	
	var lobbies = yield(_fetch.current(5), "completed")
	
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


