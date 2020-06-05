extends Control

const DEFAULT_PORT = 8910 # An arbitrary number.

onready var address = $Address
onready var status_ok = $StatusOk
onready var status_fail = $StatusFail

func _ready():
	# Connect all the callbacks related to networking.
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	get_tree().connect("connected_to_server", self, "_connected_ok")
	get_tree().connect("connection_failed", self, "_connected_fail")
	get_tree().connect("server_disconnected", self, "_server_disconnected")
	
	Gotm.connect("lobby_changed", self, "_on_Gotm_lobby_changed")
	
	if Gotm.lobby and Gotm.lobby.is_host():
		_on_host_pressed()
	else:
		_on_join_pressed()

func _on_Gotm_lobby_changed():
	if not Gotm.lobby:
		get_tree().change_scene("res://Disconnected.tscn")

#### Network callbacks from SceneTree ####

# Callback from SceneTree.
func _player_connected(_id):
	get_tree().change_scene("res://Pong.tscn")


func _player_disconnected(_id):
	if get_tree().is_network_server():
		_set_status("Client disconnected", false)
	else:
		_set_status("Server disconnected", false)


# Callback from SceneTree, only for clients (not server).
func _connected_ok():
	pass # We don't need this function.


# Callback from SceneTree, only for clients (not server).
func _connected_fail():
	_set_status("Couldn't connect", false)
	
	get_tree().set_network_peer(null) # Remove peer.
	


func _server_disconnected():
	_set_status("Server disconnected", false)

##### Game creation functions ######

func _set_status(text, isok):
	# Simple way to show status.
	if isok:
		status_ok.set_text(text)
		status_fail.set_text("")
	else:
		status_ok.set_text("")
		status_fail.set_text(text)


func _on_host_pressed():
	var host = NetworkedMultiplayerENet.new()
	host.set_compression_mode(NetworkedMultiplayerENet.COMPRESS_RANGE_CODER)
	var err = host.create_server(DEFAULT_PORT, 1) # Maximum of 1 peer, since it's a 2-player game.
	if err != OK:
		# Is another server running?
		_set_status("Can't host, address in use.",false)
		return
	
	get_tree().set_network_peer(host)
	_set_status("Waiting for player...", true)


func _on_join_pressed():
	var ip = address.get_text()
	if not ip.is_valid_ip_address():
		_set_status("IP address is invalid", false)
		return
	
	var host = NetworkedMultiplayerENet.new()
	host.set_compression_mode(NetworkedMultiplayerENet.COMPRESS_RANGE_CODER)
	host.create_client(ip, DEFAULT_PORT)
	get_tree().set_network_peer(host)
	
	_set_status("Connecting...", true)


func _on_CancelButton_pressed():
	get_tree().set_network_peer(null)
	if Gotm.lobby:
		Gotm.lobby.leave()
	get_tree().change_scene("res://Menu.tscn")
