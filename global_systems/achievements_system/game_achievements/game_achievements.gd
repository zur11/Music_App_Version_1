class_name GameAchievements extends Resource

@export var h_containing_game_name : String
@export var h_game_sessions_counter := 0
@export var h_seventyfive_percent_reached : Achievement = Achievement.new()

@export var fifty_percent_reached : Achievement = Achievement.new()
@export var eighty_percent_reached : Achievement = Achievement.new()
@export var hundred_percent_reached : Achievement = Achievement.new()
@export var daily_tries_reached : Achievement = Achievement.new()
@export var three_tried_games_reached : Achievement = Achievement.new()


func _init(current_game:Game = null):
	if current_game != null:
		h_containing_game_name = current_game.game_name

func manage_daily_tries_reached_game_signal() -> void:
	if three_tried_games_reached.unlocked: return
	
	if !daily_tries_reached.unlocked:
		daily_tries_reached.unlocked = true
	
	if h_game_sessions_counter < 3:
		h_game_sessions_counter += 1
	
	if h_game_sessions_counter == 3:
		three_tried_games_reached.unlocked = true

func manage_percentage_reached_game_signal(percentage : int) -> void:
	if hundred_percent_reached.unlocked: return
	
	if percentage == 100:
		hundred_percent_reached.unlocked = true
	if percentage == 80:
		eighty_percent_reached.unlocked = true
	if percentage >= 75:
		h_seventyfive_percent_reached.unlocked = true
	if percentage == 50:
		fifty_percent_reached.unlocked = true

