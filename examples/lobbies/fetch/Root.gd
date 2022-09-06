extends Control

onready var lobby_template = $Lobbies/LobbyTemplate
onready var lobby_list = $Lobbies/List
onready var spinner = $Lobbies/Spinner

onready var _fetch = GotmLobbyFetch.new()

const PAGE_SIZE = 5


var _lobby_count = 0
func add_lobby(name, difficulty, map, player_count):
	var lobby = GotmDebug.add_lobby()
	lobby.hidden = false
	lobby.name = name

	lobby.set_property("difficulty", difficulty)
	lobby.set_property("map", map)
	lobby.set_property("created", _lobby_count)
	lobby.set_property("player_count", player_count)


	lobby.set_sortable("difficulty")
	lobby.set_sortable("created")

	lobby.set_filterable("difficulty")
	lobby.set_filterable("map")
	
	_lobby_count += 1	


func add_lobbies():
	GotmDebug.clear_lobbies()
	add_lobby("Fun only!", 0, "classic", 3)
	add_lobby("Attack on Pencil", 1, "classic", 2)
	add_lobby("Draw bananas", 2, "classic", 1)
	
	add_lobby("Yoshi's", 0, "wall", 2)
	add_lobby("-= 1337 Battleground =-", 1, "wall", 1)
	add_lobby("[Knives only]", 2, "wall", 3)
	
	add_lobby("Why can't I hold all these lobbies", 0, "wall", 1)
	add_lobby("Creative Space", 1, "wall", 3)
	add_lobby("Draw monkeys", 2, "classic", 2)
	
	add_lobby("Everyone welcome", 2, "classic", 9)
	add_lobby("Long cat is looooooooong", 0, "wall", 1)


func _ready():
	lobby_template.hide()
	
	add_lobbies()
	
	_fetch.filter_properties = {
		"difficulty": null,
		"map": null,
	}
	_fetch.sort_property = "created"
	_fetch.sort_ascending = false
	
	reset()


func reset():
	set_lobbies(null)
	$Page/Page.text = "1"
	var lobbies = yield(_fetch.first(PAGE_SIZE), "completed")
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
		node.rect_position.y += i * 40


var _debounce_id = 0
func _on_Search_text_changed(new_text):
	set_lobbies(null)
	_debounce_id += 1
	var id = _debounce_id
	yield(get_tree().create_timer(0.75), "timeout")
	if id == _debounce_id:
		_fetch.filter_name = new_text
		reset()
	


func _on_Refresh_clicked(instance):
	set_lobbies(null)
	var lobbies = yield(_fetch.current(PAGE_SIZE), "completed")
	set_lobbies(lobbies)


func _on_First_clicked(instance):
	reset()


func _on_Previous_clicked(instance):
	set_lobbies(null)
	$Page/Page.text = str(max(int($Page/Page.text) - 1, 1))
	var lobbies = yield(_fetch.previous(PAGE_SIZE), "completed")
	set_lobbies(lobbies)


func _on_Next_clicked(instance):
	if lobby_list.get_child_count() < PAGE_SIZE:
		return
	
	set_lobbies(null)
	$Page/Page.text = str(int($Page/Page.text) + 1)
	var lobbies = yield(_fetch.next(PAGE_SIZE), "completed")
	set_lobbies(lobbies)


func _on_Map_selection_changed(text):
	if text:
		text = text.to_lower()
	_fetch.filter_properties.map = text
	reset()

func _on_Difficulty_selection_changed(text):
	if text:
		text = Utility.string_to_difficulty(text.to_lower())
	_fetch.filter_properties.difficulty = text
	reset()


func _on_SortProperty_selection_changed(text):
	_fetch.sort_property = text.to_lower()
	reset()


func _on_SortDirection_selection_changed(text):
	_fetch.sort_ascending = text == "Ascending"
	reset()
