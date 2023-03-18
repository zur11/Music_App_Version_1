class_name GameAchievements extends Resource

@export var h_containing_game_name := ""
@export var h_game_sessions_counter := 0
@export var h_seventyfive_percent_reached := false

@export var fifty_percent_reached := false
@export var eighty_percent_reached := false
@export var hundred_percent_reached := false
@export var daily_tries_reached := false
@export var three_tried_games := false


func manage_daily_tries_reached_game_signal(current_game:Game) -> void:
	if three_tried_games: return
	
	if h_containing_game_name == "":
		h_containing_game_name = current_game.game_name
	
	if !daily_tries_reached:
		daily_tries_reached = true
	
	if h_game_sessions_counter < 3:
		h_game_sessions_counter += 1
	
	if h_game_sessions_counter == 3:
		three_tried_games = true

func manage_percentage_reached_game_signal(current_game: Game, percentage : int) -> void:
	if hundred_percent_reached: return
	
	if h_containing_game_name == "":
		h_containing_game_name = current_game.game_name
	
	if percentage == 100:
		hundred_percent_reached = true
	if percentage == 80:
		eighty_percent_reached = true
	if percentage >= 75:
		h_seventyfive_percent_reached = true
	if percentage == 50:
		fifty_percent_reached = true

