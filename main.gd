extends Node2D


func _ready():
	var initial_background: Node = load("res://backgrounds/background_landscape_theme_1.tscn").instantiate()
	var initial_screen: Node = load("res://menus_screens/main_menu/main_menu.tscn").instantiate() 

	SceneManagerSystem.get_container("BackgroundContainer").goto_scene(initial_background)
	SceneManagerSystem.get_container("ScreenContainer").goto_scene(initial_screen)
	
	_load_from_disk()
	_manage_global_achievements()

func _load_from_disk():
	AchievementsManager.load_from_disk()

func _manage_global_achievements():
	var global_achievements := AchievementsManager.saved_achievements.global_achievements
	
	global_achievements.update_daily_visit_global_achievements()
	
#	printt("Times App has been opened: ", global_achievements.h_app_opened_counter)
#	printt("5 Daily Visits: ", global_achievements.five_daily_visits)
#	printt("75% in all Games Reached: ", global_achievements.seventyfive_percent_in_all_games_reached)


