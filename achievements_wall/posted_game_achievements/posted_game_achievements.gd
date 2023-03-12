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
	var game_achievements : SavedAchievements= AchievementsPersistent.load_saved_achievements_from_disk()
	
	var game_achievements_array := game_achievements.game_achievements_array
	
	for achievements in game_achievements_array:
		if achievements.containing_game_name == game_name:
			if achievements.hundred_percent_reached:
				achievements_to_post.append("hundred_percent_reached")
			if achievements.eighty_percent_reached:
				achievements_to_post.append("eighty_percent_reached")
			if achievements.fifty_percent_reached:
				achievements_to_post.append("fifty_percent_reached")
			if achievements.daily_tries_reached:
				achievements_to_post.append("daily_tries_reached")

func _add_new_achievement_rows():
	
	for achievement in achievements_to_post:
		var new_achievement_row : Node = load("res://achievements_wall/achievement_row/achievement_row.tscn").instantiate()
	
		new_achievement_row.achievement_name = achievement
		
		achievement_rows_container.add_child(new_achievement_row)
		
		
