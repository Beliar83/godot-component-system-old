extends GameSystem
class_name MovementSystem

func _init(world : GameWorld).(world):
	pass

func _before_physics_process(delta : float):
	for game_object in world.get_objects_with_component("position"):
		var position : PositionComponent = game_object.get_component("position")
		var node = world.root_node.get_node(position.node)
		if node == null:
			return
		if node is Node2D:
			node.position = position.vector
			node.rotation_degrees = position.rotation
		elif node is Spatial:
			node.translation.x = position.vector.x
			node.translation.y = position.vector.y
			node.rotation_degrees.y = position.rotation

func _physics_process(delta):
	for game_object in world.get_objects_with_component("position"):
		var position : PositionComponent = game_object.get_component("position")
		var node = world.root_node.get_node(position.node)
		if node == null:
			return
		if node is Node2D:
			position.vector = node.position
			position.rotation = node.rotation_degrees
		elif node is Spatial:
			position.vector = Vector2(node.translation.x, node.translation.y)
			position.rotation = node.rotation_degrees.y
