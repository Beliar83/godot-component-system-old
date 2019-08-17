extends WATTest

var world : GameWorld

func pre():
	world = GameWorld.new()
	world.components["Test"] = TestComponent

func test_get_objects_with_component_returns_all_components_with_name():
	var expected_objects = Array()
	var object
	object = given_map_has_object()
	expected_objects.append(object)
	object = given_map_has_object()
	expected_objects.append(object)
	object = given_map_has_object()
	expected_objects.append(object)
	object = given_map_has_object()
	expected_objects.append(object)
	var returned_components = world.get_objects_with_component("Test")
	expect.is_true(typeof(returned_components) == TYPE_ARRAY, "get_objects_with_component returns an array")
	var expected_size = expected_objects.size()
	var returned_size = returned_components.size()
	expect.is_equal(expected_size, returned_size, "Component array has correct size")
	for component in returned_components:
		expect.has(component, expected_objects, "Component array has correct objects")

func given_map_has_object():
	var object = GameObject.new()
	var counter = 0
	while world.get("Test_%s" % counter) != null:
		counter += 1
	world.set("Test_%s" % counter, object)
	object.Test.test = 0
	return object

func test_process_calls_process_on_systems():
	var test_system = TestSystem.new(world)
	world.components["Test"] = TestComponent
	var test_object = given_map_has_object()
	test_object.Test.test = 0
	watch(world, "process")
	world._process(0.1)
	expect.signal_was_emitted(world, "process", "process signal was emitted")
	expect.is_equal(1, test_object.Test.test, "Test.test is 1 after processing")

func test_process_physics_calls_process_physics_on_systems():
	var test_system = TestSystem.new(world)	
	world.components["Test"] = TestComponent
	var node = DOUBLE.script('res://tests/unit/test_node.gd')
	var scene = SceneTree.new()
	node.stub('get_tree', {}, scene)
	world.root_node = node.instance
	
	var test_object = given_map_has_object()
	test_object.Test.test = 0
	world._physics_process(0.1)	
	expect.is_equal(2, test_object.Test.test, "Test.test is 2 after processing")
