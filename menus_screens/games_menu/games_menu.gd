extends Control

func _ready():
	var games_directory = "res://games/games_tres/"
	var dir = DirAccess.open(games_directory)

	for node in get_node("%GotoGameButtons").get_children():
		node.free()

	if dir:
		for filename in dir.get_files():
			if filename.ends_with(".tres"):
				var new_goto_game_button: GotoGameButton = load("res://menus_screens/games_menu/go_to_game_button/go_to_game_button.tscn").instantiate()
				var new_game : Game = load(games_directory + filename)
				new_goto_game_button.game = new_game
				get_node("%GotoGameButtons").add_child(new_goto_game_button)
	else:
		printerr("An error occurred when trying to access folder.")

	for goto_game_button in get_node("%GotoGameButtons").get_children():
		goto_game_button.pressed.connect(_goto_game.bind(goto_game_button))

func _goto_game(goto_game_button: GotoGameButton):
	var game_screen = load("res://game_screen/game_screen_theme_1.tscn").instantiate()
	game_screen.current_game = goto_game_button.game

	SceneManagerSystem.get_container("ScreenContainer").goto_scene(game_screen)

func _on_go_back_pressed():
	SceneManagerSystem.get_container("ScreenContainer").goto_previous_scene()
