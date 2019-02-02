extends Node

var components = Dictionary()

func _ready():
	pass

func has_component(name : String):
	return components.has(name)
	
func get_component(name : String):
	if !has_component(name): # Check exists to keep the log error free.
		return null
	return components[name]
	
func create_and_add_component(component_class : GDScript, name : String):
	if has_component(name):
		return null
	var new_component = component_class.new()
	components[name] = new_component
	return new_component
	
func _get(property : String):
	return get_component(property)