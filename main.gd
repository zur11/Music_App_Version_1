extends Node2D

func _ready():
	var initial_background: Node = load("res://backgrounds/background_landscape_theme_1.tscn").instantiate()
	var initial_screen: Node = load("res://menus_screens/main_menu/main_menu.tscn").instantiate() 

	SceneManagerSystem.get_container("BackgroundContainer").goto_scene(initial_background)
	SceneManagerSystem.get_container("ScreenContainer").goto_scene(initial_screen)
