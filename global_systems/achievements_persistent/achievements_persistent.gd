extends Node

const _SAVED_ACHIEVEMENTS_PATH := "user://achievements.tres"

var saved_achievements := SavedAchievements.new()

func _init():
	load_saved_achievements_from_disk()

func replace_saved_global_achievements_var(new_achievements:GlobalAchievements) -> void:
	saved_achievements.global_achievements = new_achievements
	_save_achievements_to_disk()

func add_game_achievements_to_array(new_achievements:GameAchievements) -> void:
	var game_achievements_array = saved_achievements.game_achievements_array

	if game_achievements_array.size() != 0:
		for ii in game_achievements_array.size():
			if game_achievements_array[ii].h_containing_game_name == new_achievements.h_containing_game_name:
				game_achievements_array[ii] = new_achievements
				_save_achievements_to_disk()
				return

	game_achievements_array.append(new_achievements)
	_save_achievements_to_disk()

func _save_achievements_to_disk() -> void:
	var result = ResourceSaver.save(saved_achievements, _SAVED_ACHIEVEMENTS_PATH)
	assert(result == OK)

func load_saved_achievements_from_disk() -> SavedAchievements:
	if ResourceLoader.exists(_SAVED_ACHIEVEMENTS_PATH):
		saved_achievements = ResourceLoader.load(_SAVED_ACHIEVEMENTS_PATH) as SavedAchievements

	return saved_achievements

