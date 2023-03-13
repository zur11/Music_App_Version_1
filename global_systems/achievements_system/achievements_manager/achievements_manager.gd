extends Node



func update_global_achievements() -> GlobalAchievements:
	var global_achievements : GlobalAchievements
	
	var saved_achievements := AchievementsPersistent.load_saved_achievements_from_disk()
	global_achievements = saved_achievements.global_achievements
	
	global_achievements.daily_visit = true
	
	if global_achievements.h_app_opened_counter < 5: 
		global_achievements.h_app_opened_counter += 1
	
	if global_achievements.h_app_opened_counter == 5:
		global_achievements.five_daily_visits = true
	
	AchievementsPersistent.replace_saved_achievements_var(global_achievements)
	return global_achievements
