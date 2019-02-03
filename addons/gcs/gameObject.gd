extends Node
class_name GameObject

var world : GameWorld
var components = Dictionary()

func _init(world : GameWorld):
	self.world = world

func _ready():
	pass

func has_component(name : String) -> bool:
	return components.has(name)
	
func get_component(name : String) -> Component:
	if !has_component(name):
		if ! world.components.has(name):
			return null
		components[name] = world.components[name].new()
	return components[name]
	
func _get(property : String) -> Component:
	return get_component(property)
	
func _set(property : String, value : Component) -> bool:
	if !world.components.has(property) or !(value is world.components[property]):
		return false
	components[name] = value
	return true
	