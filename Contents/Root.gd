extends Control


func _ready():
	# Initialize the Gotm plugin.
	#
	# By default all data, such as contents, is stored locally on the player's device.
	# This means a player can see contents they created, but not contents that other players created.
	#
	# If you provide a project key, the contents will be stored on Gotm's cloud.
	# This means players can see contents created by other players.
	# You can create a project key in your game's Gotm dashboard (https://gotm.io/dashboard).
	#
	# BETA NOTICE: Contents is currently a beta feature and is stored
	# locally unless the game is running on https://gotm.io, even if you have provided a project key.
	# Using beta features is safe when using this plugin.
	var config := GotmConfig.new()
	config.project_key = "" # YOUR PROJECT KEY HERE
	Gotm.initialize(config)
	
	# Clear existing contents so the test runs the same every time.
	yield(clear_contents(), "completed")
	
	var directory = "my_directory"
	var extension = "txt"
	var basename = "my_basename" + "." + extension
	var key = directory + "/" + basename
	var string_data = "my_data"
	
	# Create scores
	var content: GotmContent = yield(GotmContent.create(var2bytes(string_data), key), "completed")

	var fetched_data: PoolByteArray = yield(GotmBlob.fetch_data(content.blob_id), "completed")
	_GotmTest.assert_equality(bytes2var(fetched_data), string_data)

	var blob: GotmBlob = yield(GotmBlob.fetch(content.blob_id), "completed")
	_GotmTest.assert_equality(blob.size, fetched_data.size())


	# Get by key
	_GotmTest.assert_resource_equality(yield(GotmContent.get_by_key(key), "completed"), content)

	# Get contents by directory
	var directory_contents: Array = yield(GotmContent.list(GotmQuery.new().filter("directory", directory)), "completed")
	_GotmTest.assert_equality(directory_contents.size(), 1)
	_GotmTest.assert_resource_equality(directory_contents[0], content)

	# Update by key
	var new_string_data: String = "my_new_data"
	var updated_content: GotmContent = yield(GotmContent.update_by_key(key, var2bytes(new_string_data)), "completed")
	_GotmTest.assert_resource_equality(updated_content, content)
	var new_fetched_data: PoolByteArray = yield(GotmBlob.fetch_data(updated_content.blob_id), "completed")
	_GotmTest.assert_equality(bytes2var(new_fetched_data), new_string_data)

	# Delete by key
	yield(GotmContent.delete_by_key(key), "completed")
	_GotmTest.assert_equality(yield(GotmContent.get_by_key(key), "completed"), null)
	_GotmTest.assert_equality(yield(GotmBlob.fetch(updated_content.blob_id), "completed"), null)
	_GotmTest.assert_equality(yield(GotmBlob.fetch_data(updated_content.blob_id), "completed"), null)

	# Create local 
	var local_content: GotmContent = yield(GotmContent.create_local(var2bytes(string_data), key), "completed")
	_GotmTest.assert_resource_equality(yield(GotmContent.fetch(local_content), "completed"), local_content)
	_GotmTest.assert_resource_equality(yield(GotmContent.get_by_key(key), "completed"), local_content)
	yield(GotmContent.delete(local_content), "completed")
	_GotmTest.assert_equality(yield(GotmContent.get_by_key(key), "completed"), null)
	_GotmTest.assert_equality(yield(GotmBlob.fetch(local_content.blob_id), "completed"), null)
	_GotmTest.assert_equality(yield(GotmBlob.fetch_data(local_content.blob_id), "completed"), null)
	
	
	# Do complex filtering
	var content1: GotmContent = yield(GotmContent.create(null, "", {"difficulty": "hard", "level": 1}), "completed")
	var content2: GotmContent = yield(GotmContent.create(null, "", {"difficulty": "medium", "level": 2}), "completed")
	var content3: GotmContent = yield(GotmContent.create(null, "", {"difficulty": "hard", "level": 3}), "completed")
	var top_level_hard: Array = yield(GotmContent.list(GotmQuery.new().filter("properties/difficulty", "hard").sort("properties/level")), "completed")
	_GotmTest.assert_resource_equality(top_level_hard, [content3, content1])
	
	# Get contents by level range
	var more_than_level_one: Array = yield(GotmContent.list(GotmQuery.new().filter_min("properties/level", 2).filter_max("properties/level", 3)), "completed")
	_GotmTest.assert_resource_equality(more_than_level_one, [content3, content2])
	
	# Search contents by partial name matching.
	var named_content: GotmContent = yield(GotmContent.create(null, "", {}, "the best map ever"), "completed")
	var best_map_search: Array = yield(GotmContent.list(GotmQuery.new().filter("namePart", "best map")), "completed")
	_GotmTest.assert_resource_equality(best_map_search, [named_content])
	yield(GotmContent.delete(named_content), "completed")
	
	# Create content only visible to us.
	var private_content: GotmContent = yield(GotmContent.create(null, "", {}, "", true), "completed")
	var my_private_contents: Array = yield(GotmContent.list(GotmQuery.new().filter("is_private", true)), "completed")
	var non_private_contents: Array = yield(GotmContent.list(), "completed")
	_GotmTest.assert_resource_equality(my_private_contents, [private_content])
	_GotmTest.assert_resource_equality(non_private_contents, [content3, content2, content1])
	
	# Upvote and downvote content.
	var auth: GotmAuth = yield(GotmAuth.fetch(), "completed")
	var upvote: GotmMark = yield(GotmMark.create(content2, "upvote"), "completed")
	var downvote: GotmMark = yield(GotmMark.create(content1, "downvote"), "completed")
	if auth.is_registered:
		var top_upvoted_contents: Array = yield(GotmContent.list(GotmQuery.new().sort("score")), "completed")
		_GotmTest.assert_resource_equality(top_upvoted_contents, [content2, content3, content1])
	_GotmTest.assert_resource_equality(yield(GotmMark.list_by_target(content2), "completed"), [upvote])
	_GotmTest.assert_resource_equality(yield(GotmMark.list_by_target(content1), "completed"), [downvote])
	
	
	# Upvote/downvote count
	var upvote_count: int = yield(GotmMark.get_count(content2, "upvote"), "completed")
	var downvote_count: int = yield(GotmMark.get_count(content1, "downvote"), "completed")
	_GotmTest.assert_equality(upvote_count, 1)
	_GotmTest.assert_equality(downvote_count, 1)
	yield(GotmMark.delete(upvote), "completed")
	yield(GotmMark.delete(downvote), "completed")
	_GotmTest.assert_equality(yield(GotmMark.get_count(content2, "upvote"), "completed"), 0)
	_GotmTest.assert_equality(yield(GotmMark.get_count(content1, "downvote"), "completed"), 0)
	
	
	print("done")


func clear_contents():
	for content in yield(GotmContent.list(), "completed"):
		yield(GotmContent.delete(content), "completed")
	for private_content in yield(GotmContent.list(GotmQuery.new().filter("is_private", true)), "completed"):
		yield(GotmContent.delete(private_content), "completed")