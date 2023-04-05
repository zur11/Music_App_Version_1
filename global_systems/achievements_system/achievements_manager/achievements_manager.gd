extends Node

var saved_achievements := SavedAchievements.new()
var achievements_persistent := AchievementsPersistent.new()

func add_game_achievements_to_array(new_achievements:GameAchievements) -> void:
	var game_achievements_array : Array[GameAchievements] = saved_achievements.game_achievements_array

	if game_achievements_array.size() != 0:
		for ii in game_achievements_array.size():
			if game_achievements_array[ii].h_containing_game_name == new_achievements.h_containing_game_name:
				game_achievements_array[ii] = new_achievements
				save_to_disk()
				return

	game_achievements_array.append(new_achievements)
	save_to_disk()
	

func save_to_disk():
	achievements_persistent.save_achievements_to_disk(saved_achievements)

func load_from_disk():
	saved_achievements = achievements_persistent.load_saved_achievements_from_disk()
