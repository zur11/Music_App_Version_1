class_name GotoGameButton extends Button

@export var game:Game

func _ready():
	if game.game_name:
		self.text = game.game_name
		self.name = game.game_name
