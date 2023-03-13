extends Node2D


	
func _ready():
	var initial_background: Node = load("res://backgrounds/background_landscape_theme_1.tscn").instantiate()
	var initial_screen: Node = load("res://menus_screens/main_menu/main_menu.tscn").instantiate() 

	SceneManagerSystem.get_container("BackgroundContainer").goto_scene(initial_background)
	SceneManagerSystem.get_container("ScreenContainer").goto_scene(initial_screen)
	
	_manage_global_achievements()

func _manage_global_achievements():
	var global_achievements := AchievementsManager.update_global_achievements()
	
	printt(global_achievements.h_app_opened_counter)
	printt(global_achievements.five_daily_visits)
