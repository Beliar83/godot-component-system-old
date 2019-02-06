extends BaseGameWorld
class_name GameWorld

func _ready():
	pass
	
func _process(delta : float):
	for system in systems:
		system._process(delta)

func get_objects_with_component(component) -> Array:
	var found_objects = Array()
	for game_object in game_objects.values():
		if game_object is GameObject:
			if game_object.has_component(component):
				found_objects.append(game_object)
	return found_objects
