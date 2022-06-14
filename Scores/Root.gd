extends Control


func _ready():
	Gotm.initialize()
	
	# Create scores
	var score1: GotmScore = yield(GotmScore.create("bananas_collected", 1), "completed")
	var score2: GotmScore = yield(GotmScore.create("bananas_collected", 2), "completed")
	var score3: GotmScore = yield(GotmScore.create("bananas_collected", 3), "completed")
	
	# Create leaderboard query.
	# You don't need to create a leaderboard before creating scores.
	var top_leaderboard = GotmLeaderboard.new()
	top_leaderboard.name = "bananas_collected"
	
	# Get top scores. 
	var top_scores = yield(top_leaderboard.get_scores(), "completed")
	_GotmTest.assert_resource_equality(top_scores, [score3, score2, score1])
	
	# Get scores above and below score2 in the leaderboard.
	var surrounding_scores = yield(top_leaderboard.get_surrounding_scores(score2.id), "completed")
	_GotmTest.assert_resource_equality(surrounding_scores.before, [score3])
	_GotmTest.assert_resource_equality(surrounding_scores.score, score2)
	_GotmTest.assert_resource_equality(surrounding_scores.after, [score1])
	
	# Get number of scores in leaderboard
	var score_count = yield(top_leaderboard.get_count(), "completed")
	_GotmTest.assert_equality(score_count, 3)
	
	# Get number of scores in ranges  [0,1), [1,2), [2,3), and [3,4], where ")" is exlusive.
	# Useful for distribution graphs.
	var score_counts = yield(top_leaderboard.get_counts(0, 4, 4), "completed")
	_GotmTest.assert_equality(score_counts, [0, 1, 1, 1])
	
	# Get rank of score3. Ranks start at 1.
	var rank_from_score_id = yield(top_leaderboard.get_rank(score3.id), "completed")
	_GotmTest.assert_equality(rank_from_score_id, 1)
	
	# Get the rank a score would have if it would have a value of 2.5.
	var rank_from_value = yield(top_leaderboard.get_rank(2.5), "completed")
	_GotmTest.assert_equality(rank_from_value, 2)
	
	# Update an existing score's value
	yield(score2.update(5), "completed")
	top_scores = yield(top_leaderboard.get_scores(), "completed")
	_GotmTest.assert_resource_equality(top_scores, [score2, score3, score1])

	# Delete a score.
	yield(score2.delete(), "completed")
	top_scores = yield(top_leaderboard.get_scores(), "completed")
	_GotmTest.assert_resource_equality(top_scores, [score3, score1])
	
	# Get scores by properties
	yield(score1.update(null, {"difficulty": "hard", "level": 25}), "completed")
	top_leaderboard.properties = {"difficulty": "hard"}
	_GotmTest.assert_resource_equality(yield(top_leaderboard.get_scores(), "completed"), [score1])
	top_leaderboard.properties = {}
	
	# Get last created score per user
	top_leaderboard.is_unique = true
	_GotmTest.assert_resource_equality(yield(top_leaderboard.get_scores(), "completed"), [score3])
	top_leaderboard.is_unique = false
	
	# Get scores from last 24 hours
	top_leaderboard.period = GotmPeriod.sliding(GotmPeriod.TimeGranularity.DAY)
	_GotmTest.assert_resource_equality(yield(top_leaderboard.get_scores(), "completed"), top_scores) ###
	top_leaderboard.period = GotmPeriod.all()
	
	# Get scores from today
	top_leaderboard.period = GotmPeriod.offset(GotmPeriod.TimeGranularity.DAY, 0)
	_GotmTest.assert_resource_equality(yield(top_leaderboard.get_scores(), "completed"), top_scores)
	top_leaderboard.period = GotmPeriod.all()
	
	# Get scores from two days ago
	top_leaderboard.period = GotmPeriod.offset(GotmPeriod.TimeGranularity.DAY, -2)
	_GotmTest.assert_resource_equality(yield(top_leaderboard.get_scores(), "completed"), [])
	top_leaderboard.period = GotmPeriod.all()
	
	# Get scores from February 2019
	top_leaderboard.period = GotmPeriod.at(GotmPeriod.TimeGranularity.MONTH, 2019, 2)
	_GotmTest.assert_resource_equality(yield(top_leaderboard.get_scores(), "completed"), [])
	top_leaderboard.period = GotmPeriod.all()
	
	
	print("done")