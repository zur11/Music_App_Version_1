extends Control


func _ready():
	_connect_goto_game_buttons()
	_update_games_achievements()
	_update_games_pre_achievements()

func _update_games_achievements():
	var saved_achievements := AchievementsPersistent.load_saved_achievements_from_disk()
	var game_achievements_array : Array = saved_achievements.game_achievements_array

	for game_achievements in game_achievements_array:
		for goto_game_button in get_node("%GotoGameButtons").get_children():
			if goto_game_button.game.game_name == game_achievements.containing_game_name:
				goto_game_button.game.game_achievements = game_achievements
				goto_game_button.update_stars_display()

func _update_games_pre_achievements():
	var saved_achievements := AchievementsPersistent.load_saved_achievements_from_disk()
	var game_pre_achievements_array : Array = saved_achievements.game_pre_achievements_array

	for game_pre_achievements in game_pre_achievements_array:
		for goto_game_button in get_node("%GotoGameButtons").get_children():
			if goto_game_button.game.game_name == game_pre_achievements.containing_game_name:
				goto_game_button.game.game_pre_achievements = game_pre_achievements
				goto_game_button.update_stars_display()

func _connect_goto_game_buttons():
	for goto_game_button in get_node("%GotoGameButtons").get_children():
		goto_game_button.pressed.connect(_goto_game.bind(goto_game_button))

func _goto_game(goto_game_button: GotoGameButton):
	var game_screen = load("res://game_screen/game_screen_theme_1.tscn").instantiate()
	game_screen.current_game = goto_game_button.game

	SceneManagerSystem.get_container("ScreenContainer").goto_scene(game_screen)

func _on_go_back_pressed():
	SceneManagerSystem.get_container("ScreenContainer").goto_previous_scene()
