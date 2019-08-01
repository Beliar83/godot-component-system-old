extends GameSystem
class_name MovementSystem

func _init(world : GameWorld).(world):
	pass

func _before_physics_process(delta : float):
	for game_object in world.get_objects_with_component("position"):
		var node = world.root_node.get_node(game_object.node)
		if node == null:
			return
		if node is Node2D:
			node.position = game_object.position.vector
			node.rotation_degrees = game_object.position.rotation
		elif node is Spatial:
			node.translation.x = game_object.position.vector.x
			node.translation.y = game_object.position.vector.y
			node.rotation_degrees.y = game_object.position.rotation

func _physics_process(delta):
	for game_object in world.get_objects_with_component("position"):
		var node = world.root_node.get_node(game_object.node)
		if node == null:
			return
		if node is Node2D:
			game_object.position.vector = node.position
			game_object.position.rotation = node.rotation_degrees
		elif node is Spatial:
			game_object.position.vector = Vector2(node.translation.x, node.translation.y)
			game_object.position.rotation = node.rotation_degrees.y
