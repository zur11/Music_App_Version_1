@tool
class_name LatestTries extends HBoxContainer

signal porcentage_reached(porcentage)

@export var number_of_tries:int = 0: set = set_number_of_tries
@export var reached_porcentage_signal_emitters: Array[int]

@export var new_try_texture:Texture = null
@export var wrong_try_texture:Texture = null
@export var correct_try_texture:Texture = null

@onready var _last_tries_array :Array[int]= [] 
@onready var _last_tries_nodes_array :Array[Node]=[] 

func _get_configuration_warning():
	return _validate_textures()

func _validate_textures() -> String:
	var validation_result = ""
	if new_try_texture == null:
		validation_result += "* new_try_texture has no texture \n"
	if wrong_try_texture == null:
		validation_result += "* wrong_try_texture has no texture \n"
	if correct_try_texture == null:
		validation_result += "* correct_try_texture has no texture \n"	
	return validation_result

func _init():
	if Engine.is_editor_hint():
		_create_arrays()
		_put_nodes_in_tree()
		
func set_number_of_tries(new_value):
	number_of_tries = new_value
	if Engine.is_editor_hint():
		_create_arrays()
		_put_nodes_in_tree()

func _ready():
	if !Engine.is_editor_hint():
		assert(_validate_textures() == "", _validate_textures())
	_create_arrays()
	_put_nodes_in_tree()

func _create_arrays():
	_last_tries_nodes_array = []
	_last_tries_array = []
	for ii in number_of_tries:
		var new_try_node 
		new_try_node = TextureRect.new()
		new_try_node.texture = new_try_texture
		_last_tries_nodes_array.push_front(new_try_node)
		_last_tries_array.push_front(0)

func _put_nodes_in_tree():
	for child in self.get_children():
		child.queue_free()
	for try_node in _last_tries_nodes_array:
		self.add_child(try_node) 

func new_try(is_correct:bool):
	_last_tries_array.pop_front()
	_last_tries_array.push_back(int(is_correct))
	
	for ii in _last_tries_nodes_array.size():
		if _last_tries_array[ii] == int(false):
			_last_tries_nodes_array[ii].texture = wrong_try_texture
		elif _last_tries_array[ii] == int(true):
			_last_tries_nodes_array[ii].texture = correct_try_texture
	
	var correct_tries = _last_tries_array.reduce(func(accum, try): return accum + try, 0)
	print(correct_tries)
	for reached_porcentage in reached_porcentage_signal_emitters:
		var reached_value = reached_porcentage * number_of_tries / 100
		if correct_tries > reached_value:
			emit_signal("porcentage_reached", reached_porcentage)
			print(reached_porcentage)
