extends Node
class_name GameWorld

const UUID = preload("res://addons/uuid/uuid.gd")

var components = Dictionary()
var systems = Dictionary()
var game_objects = Dictionary()

func _add_object(game_object : GameObject):
	while game_object.id == null or game_object.id == "" or game_objects.has(game_object.id):
		game_object.id = UUID.v4()
	game_objects[game_object.id] = game_object