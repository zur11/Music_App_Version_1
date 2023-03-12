extends Control

@onready var posted_achievements_container := $"PostedAchievementsVContainer"

func _ready():
	_find_games_containing_game_achievements()

func _find_games_containing_game_achievements():
	var saved_achievements := AchievementsPersistent.load_saved_achievements_from_disk()
	var game_achievements_array : Array = saved_achievements.game_achievements_array
	
	if game_achievements_array.size() != 0:
		for game_achievements in game_achievements_array:
			_add_new_posted_game_achievements_list(game_achievements.containing_game_name)

func _add_new_posted_game_achievements_list(game_name:String):
	var new_achievements_list : Node = load("res://achievements_wall/posted_game_achievements/posted_game_achievements.tscn").instantiate()
	new_achievements_list.game_name = game_name
	posted_achievements_container.add_child(new_achievements_list)
