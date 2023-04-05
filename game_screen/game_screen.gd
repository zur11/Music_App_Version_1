class_name GamesScreen extends Control

var correct_answer: Note

var anglo_greek_game := Game.new()
var anglo_piano_game := Game.new()

var games : Array[Game]

var current_game: Game = Game.new()


func _ready() -> void:
	set_game_scenes()

func set_game_scenes() -> void:
	set_scenes()
	await get_tree().process_frame
	restart_game()

func set_scenes() -> void:
	SceneManagerSystem.get_container("AnswerContainer").goto_scene(current_game.answers_packed_scene.instantiate())
	SceneManagerSystem.get_container("QuestionContainer").goto_scene(current_game.question_packed_scene.instantiate())

func restart_game() -> void:
	_connect_answer_emiters()
	_set_new_question()
	_connect_achievements_signals()

func _connect_achievements_signals():
	$'%LatestTries'.connect("percentage_reached", _on_percentage_reached_signal_received)
	$'%LatestTries'.connect("daily_tries_reached", _on_daily_tries_reached_signal_received)

func _connect_answer_emiters() -> void:
	for answer_emitter in get_tree().get_nodes_in_group("AnswerEmiters"):
		if (!answer_emitter.is_connected("answer_emmited", _on_recibed_answer)):
			answer_emitter.connect("answer_emmited", _on_recibed_answer)

func _on_recibed_answer(_recived_answer:Note) -> void:
	var _is_answer_correct:= _evaluate_answer(_recived_answer)
	$HUD.update_on_new_try(_is_answer_correct)
	($'%LatestTries' as LatestTries).new_try(_is_answer_correct)
	_set_new_question()

func _evaluate_answer(_recived_answer: Note) -> bool:
	return _recived_answer.relative_pitch == correct_answer.relative_pitch

func _set_new_question() -> void:
	var correct_answer_relative_pitch = randi() % 12 
	correct_answer = Note.new(correct_answer_relative_pitch)
	$QuestionContainer/Questions.set_new_question(correct_answer)
	$AnswerContainer/Answers.set_new_question(correct_answer)

func _on_daily_tries_reached_signal_received() -> void:
	var game_achievements : GameAchievements = current_game.game_achievements

	game_achievements.manage_daily_tries_reached_game_signal()
	
	AchievementsManager.add_game_achievements_to_array(game_achievements)
	
func _on_percentage_reached_signal_received(percentage) -> void:
	var game_achievements : GameAchievements = current_game.game_achievements
	
	game_achievements.manage_percentage_reached_game_signal(percentage)
	AchievementsManager.add_game_achievements_to_array(game_achievements)
	
	if game_achievements.h_seventyfive_percent_reached:
		_manage_global_achievements("seventyfive_percent_in_all_games_reached")

func _manage_global_achievements(achievement_name:String) -> void:
	var saved_achievements :SavedAchievements = AchievementsManager.saved_achievements
	var global_achievements := saved_achievements.global_achievements
	
	if achievement_name == "seventyfive_percent_in_all_games_reached":
		global_achievements.check_seventyfive_percent_in_all_games_achievement()

func _on_go_back_to_menu_button_pressed() -> void:
	SceneManagerSystem.get_container("ScreenContainer").goto_previous_scene()


