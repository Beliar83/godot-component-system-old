extends "res://addons/gut/test.gd"

var world
var movement_system
var test_object


func before_each():
	world = GameWorld.new()
	world.components["position"] = PositionComponent
	test_object = GameObject.new(world)
	movement_system = MovementSystem.new(world)

func test_process_sets_node2d_values_when_component_modified():
	gut.p("Test started")
	var node = Node2D.new()
	world.add_child(node)
	node.position.x = 0
	node.position.y = 0    
	node.rotation_degrees = 0
	test_object.position.node = node
	test_object.position.vector = node.position
	test_object.position.rotation = node.rotation_degrees
	var test_x = 100.0
	var test_angle = 45.0
	test_object.position.vector.x = test_x
	test_object.position.rotation = test_angle
	test_object.position.modified = true
	gut.simulate(world, 1, .1)
	assert_eq(node.position.x, test_x, "Expected position to have been updated")
	assert_eq(node.rotation_degrees, test_angle, "Expected rotation to have been updated")
	assert_false(test_object.position.modified, "Expected modified to have been reset")
	gut.p("Test ended")  
	
func test_process_sets_component_values_to_node2d_if_component_not_modified():
	gut.p("Test started")
	var node = Node2D.new()
	world.add_child(node)
	node.position.x = 0
	node.position.y = 0    
	node.rotation_degrees = 0
	test_object.position.node = node
	test_object.position.vector = node.position
	test_object.position.rotation = node.rotation_degrees
	var test_y = 150.0
	var test_angle = 225.0
	node.position.y = test_y
	node.rotation_degrees = test_angle
	gut.simulate(world, 1, .1)
	assert_eq(test_object.position.vector.y, test_y, "Expected position to have been updated")
	assert_eq(test_object.position.rotation, test_angle, "Expected rotation to have been updated")
	gut.p("Test ended")
	
func test_process_sets_spatial_values_when_component_modified():
	gut.p("Test started")
	var spatial = Spatial.new()
	world.add_child(spatial)
	spatial.translation.x = 0.0
	spatial.translation.y = 0.0
	spatial.translation.z = 0.0
	test_object.position.node = spatial
	test_object.position.vector = Vector2(spatial.translation.x, spatial.translation.y)
	test_object.position.rotation = spatial.rotation_degrees.y
	var test_x = 100.0
	var test_y = 150.0
	var test_angle = 45.0
	test_object.position.vector.x = test_x
	test_object.position.vector.y = test_y
	test_object.position.rotation = test_angle
	test_object.position.modified = true
	gut.simulate(world, 1, .1)
	assert_eq(spatial.translation.x, test_x, "Expected position to have been updated")
	assert_eq(spatial.translation.y, test_y, "Expected position to have been updated")
	assert_eq(spatial.rotation_degrees.y, test_angle, "Expected rotation to have been updated")
	assert_false(test_object.position.modified, "Expected modified to have been reset")
	gut.p("Test ended")

func test_process_sets_component_values_to_spatial_if_component_not_modified():
	gut.p("Test started")
	var spatial = Spatial.new()
	world.add_child(spatial)
	test_object.position.node = spatial
	test_object.position.vector = Vector2(spatial.translation.x, spatial.translation.y)
	test_object.position.rotation = spatial.rotation_degrees.y
	var test_x = 100.0
	var test_y = 150.0
	var test_angle = 45.0
	spatial.translation.x = test_x
	spatial.translation.y = test_y
	spatial.rotation_degrees.y = test_angle
	gut.simulate(world, 1, .1)
	assert_eq(test_object.position.vector.x, test_x, "Expected position to have been updated")
	assert_eq(test_object.position.vector.y, test_y, "Expected position to have been updated")
	assert_eq(test_object.position.rotation, test_angle, "Expected rotation to have been updated")
	gut.p("Test ended")    
