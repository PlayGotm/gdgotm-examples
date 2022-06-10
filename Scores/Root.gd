extends Control

func _ready():
	Gotm.initialize()
	
	# Create scores
	var score1: GotmScore = yield(GotmScore.create("bananas_collected", 1), "completed")
	var score2: GotmScore = yield(GotmScore.create("bananas_collected", 2), "completed")
	var score3: GotmScore = yield(GotmScore.create("bananas_collected", 3), "completed")
	
	var top_leaderboard = GotmLeaderboard.new()
	
	# Get top scores
	var top_scores = yield(top_leaderboard.get_scores(), "completed")
	
	# Get surrounding scores
	var surrounding_scores = yield(top_leaderboard.get_surrounding_scores(score2.id), "completed")
	
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
