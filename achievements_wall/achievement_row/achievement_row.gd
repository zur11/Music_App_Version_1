extends HBoxContainer

var achievement_name : String
@onready var achievement_name_label = $"AchievementNameLabel"

func _ready():
	achievement_name_label.text = achievement_name
