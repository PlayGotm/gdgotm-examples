extends Control



func _ready():
	$Game.hide()
	$Lobbies/List/LobbyEntry.hide()
	_on_Refresh_clicked(null)
	


func _on_LobbyEntry_selected(lobby: GotmLobby):
	$Lobbies.hide()
	$Game.show()
	
	var success = await $Game.join(lobby.address)
	if !success:
		push_error("Failed to connect to lobby '" + lobby.name + "'!")
		$Lobbies.show()
		$Game.hide()
	

func _on_Host_clicked(instance):
	$Lobbies.hide()
	$Game.show()
	
	var success = await $Game.host()
	if success:
		success = !!(await GotmLobby.create($Lobbies/Host/Name.get_text()))
		if !success:
			push_error("Failed to create lobby!")
	else:
		push_error("Failed to create server!")
		
	if !success:
		$Lobbies.hide()
		$Game.show()

func _on_Refresh_clicked(instance):
	$Lobbies/List/Spinner.show()
	for child in $Lobbies/List/Entries.get_children():
		child.queue_free()
	
	var lobbies := await GotmLobby.list()
	
	for i in lobbies.size():
		var lobby = lobbies[i]
		var node = $Lobbies/List/LobbyEntry.duplicate()
		node.show()
		$Lobbies/List/Entries.add_child(node)
		node.set_lobby(lobby)
		node.position.y += i * 80
	
	$Lobbies/List/Spinner.hide()



