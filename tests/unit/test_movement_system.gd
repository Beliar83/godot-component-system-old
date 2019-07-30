extends WATTest


var world
var movement_system

func _process(delta):
	world._process(delta)
	
func _physics_process(delta):
	world._physics_process(delta)

func pre():
	world = GameWorld.new()
	world.components["position"] = PositionComponent
	world.TestObject = GameObject.new()	
	world.root_node = TestNode.new()
	world.root_node.world = world
	movement_system = MovementSystem.new(world)

func test_process_sets_node2d_values_in_physics_process():
	var node = Node2D.new()
	world.root_node.add_child(node)
	node.position.x = 0
	node.position.y = 0    
	node.rotation_degrees = 0
	world.TestObject.position.node = world.root_node.get_path_to(node)
	world.TestObject.position.vector = node.position
	world.TestObject.position.rotation = node.rotation_degrees
	var test_x = 100.0
	var test_y = 150.0
	var test_angle = 45.0
	world.TestObject.position.vector.x = test_x
	world.TestObject.position.vector.y = test_y
	world.TestObject.position.rotation = test_angle
	simulate(world.root_node, 1, 0.1)
	expect.is_equal(node.position.x, test_x, "X position of node2d was updated")
	expect.is_equal(node.position.y, test_y, "Y position of node2d was updated")
	expect.is_equal(node.rotation_degrees, test_angle, "Rotation of node2d was updated")
	
func test_process_sets_component_values_to_node2d_in_after_physics_process():
	var node = Node2D.new()
	world.root_node.add_child(node)
	node.position.x = 0
	node.position.y = 0    
	node.rotation_degrees = 0
	world.TestObject.position.node = world.root_node.get_path_to(node)
	world.TestObject.position.vector = node.position
	world.TestObject.position.rotation = node.rotation_degrees
	var test_x = 100.0
	var test_y = 150.0
	var test_angle = 225.0
	simulate(world.root_node, 1, 0.1)
	node.position.x = test_x
	node.position.y = test_y
	node.rotation_degrees = test_angle
	world.root_node.tree.emit_idle_frame()
	expect.is_equal(world.TestObject.position.vector.x, test_x, "X position of component was updated")
	expect.is_equal(world.TestObject.position.vector.y, test_y, "Y position of component was updated")
	expect.is_equal(world.TestObject.position.rotation, test_angle, "Rotation of component was updated")

func test_process_sets_spatial_values_in_physics_process():
	var spatial = Spatial.new()
	world.root_node.add_child(spatial)
	spatial.translation.x = 0.0
	spatial.translation.y = 0.0
	spatial.translation.z = 0.0
	world.TestObject.position.node = world.root_node.get_path_to(spatial)
	world.TestObject.position.vector = Vector2(spatial.translation.x, spatial.translation.y)
	world.TestObject.position.rotation = spatial.rotation_degrees.y
	var test_x = 100.0
	var test_y = 150.0
	var test_angle = 45.0
	world.TestObject.position.vector.x = test_x
	world.TestObject.position.vector.y = test_y
	world.TestObject.position.rotation = test_angle
	simulate(world.root_node, 1, 0.1)
	expect.is_equal(spatial.translation.x, test_x, "X position of spatial was updated")
	expect.is_equal(spatial.translation.y, test_y, "Y position of spatial was updated")
	expect.is_equal(spatial.rotation_degrees.y, test_angle, "Rotation of spatial was updated")
	emit_signal("test_done")

func test_process_sets_component_values_to_spatial_in_after_physics_process():
	var spatial = Spatial.new()
	world.root_node.add_child(spatial)
	world.TestObject.position.node = world.root_node.get_path_to(spatial)
	world.TestObject.position.vector = Vector2(spatial.translation.x, spatial.translation.y)
	world.TestObject.position.rotation = spatial.rotation_degrees.y
	simulate(world.root_node, 2, 0.1)
	var test_x = 100.0
	var test_y = 150.0
	var test_angle = 45.0
	spatial.translation.x = test_x
	spatial.translation.y = test_y
	spatial.rotation_degrees.y = test_angle
	world.root_node.tree.emit_idle_frame()
	expect.is_equal(world.TestObject.position.vector.x, test_x, "X position of component was updated")
	expect.is_equal(world.TestObject.position.vector.y, test_y, "Y position of component was updated")
	expect.is_equal(world.TestObject.position.rotation, test_angle, "Rotation of component was updated")
