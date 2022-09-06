extends Node


const TEST_PATHS := [
	"res://tests/ContentsTest.gd",
	"res://tests/LeaderboardsTest.gd",
]



class Test:
	var suite: Script
	var name: String



static func get_tests() -> Array:
	var tests := []
	for path in TEST_PATHS:
		var script: Script = load(path)
		for prop in script.get_script_method_list():
			if prop.name.begins_with("_"):
				continue
			var test := Test.new()
			test.suite = script
			test.name = prop.name
			tests.append(test)
	return tests


func _ready():
	var tests := get_tests()
	print("Running ", tests.size(), "/", tests.size(), " tests")
	for i in range(0, tests.size()):
		var test: Test = tests[i]
		yield(test.suite.call(test.name), "completed")
