extends Control


onready var _fetch = GotmLobbyFetch.new()

func _ready():
	Gotm.connect("lobby_changed", self, "_on_Gotm_lobby_changed")
	$Game.hide()
	$Lobbies/List/LobbyEntry.hide()
	_on_Refresh_clicked(null)
	


func _on_LobbyEntry_selected(lobby):
	$Lobbies.hide()
	$Game.show()
	
	$Game/Spinner.show()
	$Game/Instructions.hide()
	var success = yield(lobby.join(), "completed")
	$Game/Spinner.hide()
	$Game/Instructions.show()
	if success:
		$Game.join()
	else:
		push_error("Failed to connect to lobby '" + lobby.name + "'!")
		$Lobbies.show()
		$Game.hide()


func _on_Host_clicked(instance):
	$Lobbies.hide()
	$Game.show()
	
	Gotm.host_lobby(false)
	Gotm.lobby.hidden = false
	Gotm.lobby.name = $Lobbies/Host/Name.get_text()
	$Game.host()


func _on_Refresh_clicked(instance):
	$Lobbies/List/Spinner.show()
	for child in $Lobbies/List/Entries.get_children():
		child.queue_free()
	
	var lobbies = yield(_fetch.first(5), "completed")
	
	for i in range(lobbies.size()):
		var lobby = lobbies[i]
		var node = $Lobbies/List/LobbyEntry.duplicate()
		node.show()
		$Lobbies/List/Entries.add_child(node)
		node.set_lobby(lobby)
		node.rect_position.y += i * 80
	
	$Lobbies/List/Spinner.hide()


func _on_Gotm_lobby_changed():
	if not Gotm.lobby:
		$Lobbies.show()
		$Game.hide()



