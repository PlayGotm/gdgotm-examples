extends Control

onready var lobby_template = $Navigator/Lobbies/LobbyTemplate
onready var lobby_list = $Navigator/Lobbies/List
onready var spinner = $Navigator/Lobbies/Spinner

onready var fetch = GotmLobbyFetch.new()

const PAGE_SIZE = 4

var _test_lobby_count = 0
func add_test_lobby(name, difficulty, map, player_count):
	if Gotm.is_live():
		return
		
	var lobby = GotmDebug.add_lobby()
	initialize_lobby(lobby, name, difficulty, map)
	lobby.set_property("created", _test_lobby_count)
	lobby.set_property("player_count", player_count)
	_test_lobby_count += 1
	

func initialize_lobby(lobby, name, difficulty, map):
	lobby.hidden = false
	lobby.name = name

	lobby.set_property("difficulty", difficulty)
	lobby.set_property("map", map)
	lobby.set_property("created", OS.get_unix_time())
	lobby.set_property("player_count", 1)


	lobby.set_sortable("difficulty")
	lobby.set_sortable("created")

	lobby.set_filterable("difficulty")
	lobby.set_filterable("map")


func add_test_lobbies():
	GotmDebug.clear_lobbies()
	add_test_lobby("Fun only!", 0, "classic", 1)
	add_test_lobby("Yoshi's", 1, "wall", 2)
	add_test_lobby("-= 1337 Battleground =-", 2, "wall", 3)
	add_test_lobby("[Knives only]", 2, "wall", 3)
	add_test_lobby("Why can't I hold all these lobbies", 2, "wall", 3)
	
	
func _on_gotm_files_dropped(files, screen):
	for file in files:
		print(file.name)
		for i in range(16):
			print(file.data[i])
		print(file.modified_time)
		print("---")

# Called when the node enters the scene tree for the first time.
func _ready():
	lobby_template.hide()
	
	if not Gotm.is_live():
		add_test_lobbies()

	
	fetch.filter_properties = {
		"difficulty": null,
		"map": null,
	}
	fetch.sort_property = "created"
	fetch.sort_ascending = false
	
	reset()
	

func reset():
	set_lobbies(null)
	$Navigator/Page/Page.text = "1"
	var lobbies = yield(fetch.first(PAGE_SIZE), "completed")
	set_lobbies(lobbies)


func set_lobbies(lobbies):
	for child in lobby_list.get_children():
		child.queue_free()
	
	if lobbies == null:
		spinner.show()
		return
		
	spinner.hide()
	for i in range(lobbies.size()):
		var lobby = lobbies[i]
		var node = lobby_template.duplicate()
		node.show()
		lobby_list.add_child(node)
		node.set_lobby(lobby)
		node.rect_position.y += i * 80
	

func _on_LobbyTemplate_selected(lobby):
	var success = yield(lobby.join(), "completed")
	if success:
		get_tree().change_scene("res://Lobby.tscn")
	else:
		print("Failed to connect to lobby '" + lobby.name + "'!")


func _on_Classic_clicked(instance):
	instance.filled = !instance.filled
	if instance.filled:
		$Navigator/Options/Map/Wall.filled = false
		fetch.filter_properties.map = "classic"
	else:
		fetch.filter_properties.map = null
		
	reset()


func _on_Wall_clicked(instance):
	instance.filled = !instance.filled
	if instance.filled:
		$Navigator/Options/Map/Classic.filled = false
		fetch.filter_properties.map = "wall"
	else:
		fetch.filter_properties.map = null
	reset()


func _on_Easy_clicked(instance):
	instance.filled = !instance.filled
	if instance.filled:
		$Navigator/Options/Difficulty/Medium.filled = false
		$Navigator/Options/Difficulty/Hard.filled = false
		fetch.filter_properties.difficulty = 0
	else:
		fetch.filter_properties.difficulty = null
	reset()


func _on_Medium_clicked(instance):
	instance.filled = !instance.filled
	if instance.filled:
		$Navigator/Options/Difficulty/Easy.filled = false
		$Navigator/Options/Difficulty/Hard.filled = false
		fetch.filter_properties.difficulty = 1
	else:
		fetch.filter_properties.difficulty = null
	reset()


func _on_Hard_clicked(instance):
	instance.filled = !instance.filled
	if instance.filled:
		$Navigator/Options/Difficulty/Easy.filled = false
		$Navigator/Options/Difficulty/Medium.filled = false
		fetch.filter_properties.difficulty = 2
	else:
		fetch.filter_properties.difficulty = null
	reset()


func _on_SortAge_clicked(instance):
	instance.filled = true
	$Navigator/Options/Sort/SortDifficulty.filled = false
	fetch.sort_property = "created"
	reset()


func _on_SortDifficulty_clicked(instance):
	instance.filled = true
	$Navigator/Options/Sort/SortAge.filled = false
	fetch.sort_property = "difficulty"
	reset()


func _on_SortDescending_clicked(instance):
	instance.filled = true
	$Navigator/Options/Sort/SortAscending.filled = false
	fetch.sort_ascending = false
	reset()


func _on_SortAscending_clicked(instance):
	instance.filled = true
	$Navigator/Options/Sort/SortDescending.filled = false
	fetch.sort_ascending = true
	reset()


func _on_Search_text_changed(new_text):
	fetch.filter_name = new_text
	reset()






func _on_Refresh_clicked(instance):
	set_lobbies(null)
	var lobbies = yield(fetch.current(PAGE_SIZE), "completed")
	set_lobbies(lobbies)


func _on_First_clicked(instance):
	reset()

func _on_Previous_clicked(instance):
	set_lobbies(null)
	$Navigator/Page/Page.text = str(max(int($Navigator/Page/Page.text) - 1, 1))
	var lobbies = yield(fetch.previous(PAGE_SIZE), "completed")
	set_lobbies(lobbies)


func _on_Next_clicked(instance):
	if lobby_list.get_child_count() < PAGE_SIZE:
		return
	
	set_lobbies(null)
	$Navigator/Page/Page.text = str(int($Navigator/Page/Page.text) + 1)
	var lobbies = yield(fetch.next(PAGE_SIZE), "completed")
	set_lobbies(lobbies)






func _on_CreateGame_clicked(instance):
	Gotm.host_lobby()
	initialize_lobby(Gotm.lobby, "My lobby", 1, "classic")
	get_tree().change_scene("res://Lobby.tscn")
