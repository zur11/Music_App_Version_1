class_name GotoGameButton extends Button

@export var game:Game

@onready var stars_h_container := $"%StarsHContainer"
@onready var tries_stars_h_container := $"%TriesStarsHContainer"

@onready var star_on : Texture = load("res://assets/theme_1/images/go_to_game_button/star_on.png")
@onready var red_star_on : Texture = load("res://assets/theme_1/images/go_to_game_button/red_star_on.png")

func _ready():
	if game.game_name:
		self.text = game.game_name
		self.name = game.game_name

func update_stars_display():
	if game.game_achievements.three_tried_games:
			for star in tries_stars_h_container.get_children():
				star.texture = red_star_on

	if game.game_achievements.daily_tries_reached:
		tries_stars_h_container.get_child(0).texture = red_star_on
	
	if game.game_achievements.hundred_percent_reached:
		for star in stars_h_container.get_children():
			star.texture = star_on
		return
	if game.game_achievements.eighty_percent_reached:
		stars_h_container.get_child(0).texture = star_on
		stars_h_container.get_child(1).texture = star_on
		return
	if game.game_achievements.fifty_percent_reached:
		stars_h_container.get_child(0).texture = star_on
