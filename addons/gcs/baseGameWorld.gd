extends Node
class_name BaseGameWorld

const UUID = preload("res://addons/uuid/uuid.gd")

var components = Dictionary()
var systems = Array()
var game_objects = Dictionary()

func _add_object(game_object : BaseGameObject):
	while game_object.id == null or game_object.id == "" or game_objects.has(game_object.id):
		game_object.id = UUID.v4()
	game_objects[game_object.id] = game_object
	
func _add_system(game_system : BaseGameSystem):
	systems.append(game_system)
