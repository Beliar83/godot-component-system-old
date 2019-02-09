extends BaseGameObject
class_name GameObject

var world : BaseGameWorld

func _init(world : BaseGameWorld):
	self.world = world
	world._add_object(self)

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
	components[property] = value
	return true
