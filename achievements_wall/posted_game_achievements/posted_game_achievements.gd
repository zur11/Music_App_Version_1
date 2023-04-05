extends CenterContainer

var game_name : String
var achievements_to_post : Array[String]
@onready var game_name_label := $"%GameNameLabel"
@onready var achievement_rows_container := $"%AchievementRowsContainer"

func _ready():
	game_name_label.text = game_name
	_get_achievements_names()
	_add_new_achievement_rows()


func _get_achievements_names():
	var game_achievements_array :Array[GameAchievements] = AchievementsManager.saved_achievements.game_achievements_array
	
	for achievements in game_achievements_array:
		if achievements.h_containing_game_name == game_name:
			if achievements.hundred_percent_reached.unlocked:
				achievements_to_post.append("Hundred Percent Reached")
			if achievements.eighty_percent_reached.unlocked:
				achievements_to_post.append("Eighty Percent Reached")
			if achievements.fifty_percent_reached.unlocked:
				achievements_to_post.append("Fifty Percent Reached")
			if achievements.three_tried_games_reached.unlocked:
				achievements_to_post.append("Three Tried Games")
			if achievements.daily_tries_reached.unlocked:
				achievements_to_post.append("Daily Tries Reached")

func _add_new_achievement_rows():
	
	for achievement in achievements_to_post:
		var new_achievement_row : Node = load("res://achievements_wall/achievement_row/achievement_row.tscn").instantiate()
	
		new_achievement_row.achievement_name = achievement
		
		achievement_rows_container.add_child(new_achievement_row)
		
		
