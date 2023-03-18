extends Control


func _ready() -> void:
	_connect_goto_game_buttons()
	_update_games_achievements()

func _update_games_achievements() -> void:
	var saved_achievements := AchievementsPersistent.load_saved_achievements_from_disk()
	var game_achievements_array : Array = saved_achievements.game_achievements_array
	var global_achievements := saved_achievements.global_achievements

	for goto_game_button in get_node("%GotoGameButtons").get_children():
		for game_achievements in game_achievements_array:
			if goto_game_button.game.game_name == game_achievements.h_containing_game_name:
				goto_game_button.game.game_achievements = game_achievements
				goto_game_button.update_stars_display()
		
		global_achievements.register_game_in_array(goto_game_button.game)
	
	AchievementsPersistent.replace_saved_global_achievements_var(global_achievements)

func _connect_goto_game_buttons() -> void:
	for goto_game_button in get_node("%GotoGameButtons").get_children():
		goto_game_button.pressed.connect(_goto_game.bind(goto_game_button))

func _goto_game(goto_game_button: GotoGameButton) -> void:
	var game_screen = load("res://game_screen/game_screen_theme_1.tscn").instantiate()
	game_screen.current_game = goto_game_button.game

	SceneManagerSystem.get_container("ScreenContainer").goto_scene(game_screen)

func _on_go_back_pressed() -> void:
	SceneManagerSystem.get_container("ScreenContainer").goto_previous_scene()
