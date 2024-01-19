extends Control

func _ready():
	$Menu.show()
	$Game.hide()


func _on_Host_clicked(instance):	
	$Menu.hide()
	$Game.show()
	var success = await $Game.host()
	if !success:
		push_error("Failed to create server!")
		$Menu.show()
		$Game.hide()
		return
	var address = await GotmMultiplayer.get_address()
	print("Created server with address '" + address + "'!")

func _on_Join_clicked(instance):
	var args := OS.get_cmdline_user_args()
	var address = ""
	for arg in args:
		if arg.begins_with("--address="):
			address = arg.substr("--address=".length())
			break
	
	address = await GotmMultiplayer.get_address()
	if !address:
		push_error("No server address provided!")
		return
		
	$Menu.hide()
	$Game.show()
	var success = await $Game.join(address)
	if !success:
		push_error("Failed to join server with address '" + address + "'!")
		$Menu.show()
		$Game.hide()


func _on_game_link_copied(address: String):
		DisplayServer.clipboard_set("https://gotm.io/gdgotm-examples/multiplayer?appArguments=--address=" + address)
