class_name Game extends Resource

@export var game_name: String : set = _set_game_name_and_initiate_achievements
@export var game_achievements : GameAchievements

@export var question_packed_scene: PackedScene
@export var answers_packed_scene: PackedScene


func _set_game_name_and_initiate_achievements(new_value:String) -> void:
	game_name = new_value
	
	if game_name == "": return
	
	if not game_achievements:
		game_achievements = GameAchievements.new(self)
