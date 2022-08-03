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
	
#	config.project_key = "authenticators/AdcCjcOXLW1F5W2UWZYx" # development
##	config.project_key = "authenticators/fDyAbF0mfFcgnTghU8Jz" # production
#	config.betaUnsafeForceGlobalScores = true
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
	var new_string_data = "my_new_data"
	var updated_content: GotmContent = yield(GotmContent.update_by_key(key, var2bytes(new_string_data)), "completed")
	_GotmTest.assert_resource_equality(updated_content, content)
	var new_fetched_data = yield(GotmBlob.fetch_data(updated_content.blob_id), "completed")
	_GotmTest.assert_equality(bytes2var(new_fetched_data), new_string_data)
	
	# Delete by key
	yield(GotmContent.delete_by_key(key), "completed")
	_GotmTest.assert_equality(yield(GotmContent.get_by_key(key), "completed"), null)
	_GotmTest.assert_equality(yield(GotmBlob.fetch(updated_content.blob_id), "completed"), null)
	
	
	# List
	# Demonstrate some interesting queries. Point to GotmContent.list for a full list of query options.
	
	# List private
	# Demonstrate empty list if fetching all private or another author's private.
	
	# Create local
	# List local
	
	
	#static func create(data = null, properties: Dictionary = {}, key: String = "", name: String = "", private: bool = false)  -> GotmContent:
	print("done")


func clear_contents():
	var directory = "my_directory"
	var directory_contents: Array = yield(GotmContent.list(GotmQuery.new().filter("directory", directory)), "completed")
	for content in directory_contents:
		yield(GotmContent.delete(content), "completed")