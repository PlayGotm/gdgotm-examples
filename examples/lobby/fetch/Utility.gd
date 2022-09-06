static func difficulty_to_string(difficulty):
	match int(difficulty):
		0:
			return "easy"
		1:
			return "medium"
		2:
			return "hard"
		_:
			return "???"

static func string_to_difficulty(string):
	match string:
		"easy":
			return 0
		"medium":
			return 1
		"hard":
			return 2
		_:
			return 0
