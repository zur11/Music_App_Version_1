class_name GlobalAchievements extends Resource


@export var daily_visit : Achievement = Achievement.new() 
@export var five_daily_visits : Achievement = Achievement.new() 
@export var seventyfive_percent_in_all_games_reached : Achievement = Achievement.new() 

@export var _registered_games : Array[Game]
@export var h_app_opened_counter := 0


func update_daily_visit_global_achievements() -> void:
	daily_visit.unlocked = true
	
	if h_app_opened_counter < 5: 
		h_app_opened_counter += 1
	
	if h_app_opened_counter == 5:
		five_daily_visits.unlocked = true

func register_game_in_array(new_game:Game) -> void:
	if _registered_games.size() != 0:
		for ii in _registered_games.size():
			if _registered_games[ii].game_name == new_game.game_name: 
				_registered_games[ii] = new_game
				return
	_registered_games.append(new_game)

func check_seventyfive_percent_in_all_games_achievement() -> void:
	var games_reached_seventyfive_percent_counter := 0
	
	for game in _registered_games:
		if game.game_achievements.h_seventyfive_percent_reached.unlocked:
			games_reached_seventyfive_percent_counter += 1
	
#	printt("games that reached 75% counter: ", games_reached_seventyfive_percent_counter)
	
	if games_reached_seventyfive_percent_counter == 5:
			seventyfive_percent_in_all_games_reached.unlocked = true
			printt("75% in all Games Reached! ", seventyfive_percent_in_all_games_reached.unlocked)

