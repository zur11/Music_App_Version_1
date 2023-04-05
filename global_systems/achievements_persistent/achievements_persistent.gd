class_name AchievementsPersistent extends Resource


func save_achievements_to_disk(achievements_to_save:SavedAchievements) -> void:
	var result = ResourceSaver.save(achievements_to_save, "user://achievements.tres")
	assert(result == OK)

func load_saved_achievements_from_disk() -> SavedAchievements:
	var saved_achievements:SavedAchievements = SavedAchievements.new()
	
	if ResourceLoader.exists("user://achievements.tres"):
		saved_achievements = ResourceLoader.load("user://achievements.tres") as SavedAchievements

	return saved_achievements

