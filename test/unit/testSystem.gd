extends GameSystem
class_name TestSystem

func _init(world : GameWorld).(world):
	pass

func _process(delta : float):
	._process(delta)
	for object in (world as GameWorld).get_objects_with_component("Test"):
		(object.Test as TestComponent).test = 1

func _physics_process(delta : float):
	._physics_process(delta)
	for object in (world as GameWorld).get_objects_with_component("Test"):
		(object.Test as TestComponent).test = 2
