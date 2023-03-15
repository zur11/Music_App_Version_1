extends Node


var _registered_games : Array[Game]


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
		if game.game_achievements.h_seventyfive_percent_reached:
			games_reached_seventyfive_percent_counter += 1
	
	if games_reached_seventyfive_percent_counter == 5:
			var saved_achievements := AchievementsPersistent.load_saved_achievements_from_disk()
			var global_achievements := saved_achievements.global_achievements
			
			global_achievements.seventyfive_percent_in_all_games_reached = true
			printt("75% in all Games Reached! ", global_achievements.seventyfive_percent_in_all_games_reached)

func update_daily_visit_global_achievements() -> GlobalAchievements:
	var saved_achievements := AchievementsPersistent.load_saved_achievements_from_disk()
	var global_achievements := saved_achievements.global_achievements
	
	global_achievements.daily_visit = true
	
	if global_achievements.h_app_opened_counter < 5: 
		global_achievements.h_app_opened_counter += 1
	
	if global_achievements.h_app_opened_counter == 5:
		global_achievements.five_daily_visits = true
	
	AchievementsPersistent.replace_saved_global_achievements_var(global_achievements)
	return global_achievements

func update_played_games_global_achievements() -> GlobalAchievements:
	var saved_achievements := AchievementsPersistent.load_saved_achievements_from_disk()
	var global_achievements := saved_achievements.global_achievements

	global_achievements.h_games_seventy_percent_reached_counter += 1
	
	AchievementsPersistent.replace_saved_global_achievements_var(global_achievements)
	return global_achievements

func manage_percentage_reached_game_signal(current_game: Game, percentage : int) -> void:
	if current_game.game_achievements.hundred_percent_reached: return
	
	current_game.game_achievements.h_containing_game_name = current_game.game_name
	
	if percentage == 100:
		current_game.game_achievements.hundred_percent_reached = true
	if percentage == 80:
		current_game.game_achievements.eighty_percent_reached = true
	if percentage >= 75:
				current_game.game_achievements.h_seventyfive_percent_reached = true
				check_seventyfive_percent_in_all_games_achievement() 
				
	if percentage == 50:
		current_game.game_achievements.fifty_percent_reached = true
	
	AchievementsPersistent.add_game_achievements_to_array(current_game.game_achievements)

func manage_daily_tries_reached_game_signal(current_game:Game) -> void:
	if current_game.game_achievements.three_tried_games: return
	
	current_game.game_achievements.h_containing_game_name = current_game.game_name
	
	if !current_game.game_achievements.daily_tries_reached:
		current_game.game_achievements.daily_tries_reached = true
	
	if current_game.game_achievements.h_game_sessions_counter < 3:
		current_game.game_achievements.h_game_sessions_counter += 1
	
	if current_game.game_achievements.h_game_sessions_counter == 3:
		current_game.game_achievements.three_tried_games = true
	
	AchievementsPersistent.add_game_achievements_to_array(current_game.game_achievements)
