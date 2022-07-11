extends Control

func _ready():
	# Initialize the Gotm plugin.
	#
	# By default all data, such as scores, is stored locally on the player's device.
	# This means a player can see their own scores, but not scores from other players.
	#
	# If you provide a project key, the data will be stored on Gotm's cloud.
	# This means players can see each other's scores.
	# You can create a project key in your game's Gotm dashboard (https://gotm.io/dashboard).
	#
	# BETA NOTICE: Scores and leaderboards are currently beta features and are stored
	# locally unless the game is running on https://gotm.io, even if you have provided a project key.
	# Using beta features is safe when using this plugin.
	var config := GotmConfig.new()
	config.project_key = "" # YOUR PROJECT KEY HERE
	Gotm.initialize(config)
	
	
	# Give our scores a descriptive name.
	# We need this later when fetching scores.
	var score_name := "bananas_collected"
	
	# Clear existing scores so the test runs the same every time.
	yield(clear_scores(score_name), "completed")
	
	# Create scores
	var score1: GotmScore = yield(GotmScore.create(score_name, 1), "completed")
	var score2: GotmScore = yield(GotmScore.create(score_name, 2), "completed")
	var score3: GotmScore = yield(GotmScore.create(score_name, 3), "completed")
	
	# Create leaderboard query.
	# You don't need to create a leaderboard before creating scores.
	var top_leaderboard = GotmLeaderboard.new()
	# Required. 
	# Only include scores in our "bananas_collected" category.
	top_leaderboard.name = score_name
	
	# Get top scores. 
	var top_scores = yield(top_leaderboard.get_scores(), "completed")
	_GotmTest.assert_resource_equality(top_scores, [score3, score2, score1])
	
	# Get scores above and below score2 in the leaderboard.
	var surrounding_scores = yield(top_leaderboard.get_surrounding_scores(score2), "completed")
	_GotmTest.assert_resource_equality(surrounding_scores.before, [score3])
	_GotmTest.assert_resource_equality(surrounding_scores.score, score2)
	_GotmTest.assert_resource_equality(surrounding_scores.after, [score1])
	
	# Get scores above and below score2 in the leaderboard with id.
	var surrounding_scores_by_id = yield(top_leaderboard.get_surrounding_scores(score2.id), "completed")
	_GotmTest.assert_resource_equality(surrounding_scores_by_id.before, [score3])
	_GotmTest.assert_resource_equality(surrounding_scores_by_id.score, score2)
	_GotmTest.assert_resource_equality(surrounding_scores_by_id.after, [score1])
	
	# Get scores above and below a certain value in the leaderboard.
	var surrounding_scores_by_value = yield(top_leaderboard.get_surrounding_scores(2.5), "completed")
	_GotmTest.assert_resource_equality(surrounding_scores_by_value.before, [score3])
	_GotmTest.assert_resource_equality(surrounding_scores_by_value.score, score2)
	_GotmTest.assert_resource_equality(surrounding_scores_by_value.after, [score1])
	
	# Get scores above and below a certain rank in the leaderboard.
	var surrounding_scores_by_rank = yield(top_leaderboard.get_surrounding_scores_by_rank(2), "completed")
	_GotmTest.assert_resource_equality(surrounding_scores_by_rank.before, [score3])
	_GotmTest.assert_resource_equality(surrounding_scores_by_rank.score, score2)
	_GotmTest.assert_resource_equality(surrounding_scores_by_rank.after, [score1])
	
	# Get scores below score2
	var scores_after_score = yield(top_leaderboard.get_scores(score2), "completed")
	_GotmTest.assert_resource_equality(scores_after_score, [score1])
	
	# Get scores below score2 with id	
	var scores_after_score_id = yield(top_leaderboard.get_scores(score2.id), "completed")
	_GotmTest.assert_resource_equality(scores_after_score_id, [score1])
	
	# Get scores with lower value than score2
	var scores_after_value = yield(top_leaderboard.get_scores(score2.value), "completed")
	_GotmTest.assert_resource_equality(scores_after_value, [score1])
	
	# Get scores below rank 1
	var scores_after_rank = yield(top_leaderboard.get_scores_by_rank(1), "completed")
	_GotmTest.assert_resource_equality(scores_after_rank, [score2, score1])
	
	# Get number of scores in leaderboard.
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
	
	# Invert the leaderboard query, so that a lower value means a higher rank.
	top_leaderboard.is_inverted = true
	var inverted_rank = yield(top_leaderboard.get_rank(score3.id), "completed")
	_GotmTest.assert_equality(inverted_rank, 3)
	top_leaderboard.is_inverted = false
	
	# Invert the leaderboard query, so scores with a lower value come first.
	top_leaderboard.is_inverted = true
	var inverted_scores = yield(top_leaderboard.get_scores(), "completed")
	_GotmTest.assert_resource_equality(inverted_scores, [score1, score2, score3])
	top_leaderboard.is_inverted = false
	
	# Newer scores are ranked higher than older scores with the same value.
	var score1_copy: GotmScore = yield(GotmScore.create(score1.name, score1.value), "completed")
	var score1_copy_rank_with_newest_first = yield(top_leaderboard.get_rank(score1_copy), "completed")
	_GotmTest.assert_equality(score1_copy_rank_with_newest_first, 3)
	
	# Make older scores rank higher than newer scores with the same value.
	top_leaderboard.is_oldest_first = true
	var score1_copy_rank_with_oldest_first = yield(top_leaderboard.get_rank(score1_copy), "completed")
	_GotmTest.assert_equality(score1_copy_rank_with_oldest_first, 4)
	top_leaderboard.is_oldest_first = false
	yield(score1_copy.delete(), "completed")
	
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
	
	# If the score was created with a signed in user on Gotm, get the display name.
	var user: GotmUser = yield(GotmUser.fetch(score1.user_id), "completed")
	if user:
		# User is a registered Gotm user and has a display name.
		# Access it with the user.display_name field.
		pass 
	else:
		# User is not registered and has no display name.
		pass 
	
	print("done")


func clear_scores(score_name: String):
	var existing_leaderboard = GotmLeaderboard.new()
	existing_leaderboard.name = score_name
	var existing_scores = yield(existing_leaderboard.get_scores(), "completed")
	for score in existing_scores:
		yield(score.delete(), "completed")
