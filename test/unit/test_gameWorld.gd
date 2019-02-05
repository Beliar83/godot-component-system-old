extends "res://addons/gut/test.gd"

const GameWorld = preload("res://addons/gcs/gameWorld.gd")
const GameObject = preload("res://addons/gcs/gameObject.gd")
const GameSystem = preload("res://addons/gcs/gameSystem.gd")
const TestComponent = preload("res://test/unit/testComponent.gd")

var world : GameWorld

func before_each():
	world = GameWorld.new()
	world.components["Test"] = TestComponent
	
func test_get_objects_with_component_returns_all_components_with_name():
	gut.p("Test started")
	var expected_objects = Array()
	var object
	object = given_map_has_object()
	object.Test.modified = false
	expected_objects.append(object)
	object = given_map_has_object()
	object.Test.modified = false
	expected_objects.append(object)
	object = given_map_has_object()
	object.Test.modified = false
	expected_objects.append(object)
	object = given_map_has_object()
	var returned_components = world.get_objects_with_component("Test")
	assert_true(typeof(returned_components) == TYPE_ARRAY, "Expected returned components to be an array")
	var expected_size = expected_objects.size()
	var returned_size = returned_components.size()
	var have_same_size = expected_size == returned_size
	assert_true(have_same_size, "Expected both arrays to have the same values")
	if have_same_size:
		for component in returned_components:
			assert_has(expected_objects, component, "Expected both arrays to have the same values")
	gut.p("Test ended")
	
func given_map_has_object():
	var object = GameObject.new(world)
	var components = Node.new()
	return object
	
