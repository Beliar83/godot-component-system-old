extends WATTest

var gameWorld : BaseGameWorld;
var gameObject : GameObject;

func pre():
	gameWorld = GameWorld.new()
	gameWorld.TestObject = GameObject.new()
	gameObject = gameWorld.TestObject
	
func test_game_object_is_in_world():
	expect.has(gameObject.id, gameWorld.game_objects.keys(), "World contains the id of the game object")
	expect.is_equal(gameWorld.game_objects[gameObject.id], gameObject, "Game object stored in world is correct")

func test_has_returns_true_on_existing_component():
	var test_component = TestComponent.new()
	gameObject.components["Test"] = test_component
	expect.is_true(gameObject.has_component("Test"), "Test component exists in game object")

func test_has_returns_false_for_non_existing_component():
	expect.is_false(gameObject.has_component("Test"), "Test component does not exist in game object")

func test_get_returns_existing_component():
	var test_component = TestComponent.new()
	gameObject.components["Test"] = test_component
	expect.is_equal(gameObject.get_component("Test"), test_component, "Component of game object was set correctly")

func test_get_creates_component_if_it_does_not_exist():
	gameWorld.components["Test"] = TestComponent
	var new_component = gameObject.get_component("Test")
	expect.is_not_equal(new_component, null, "Component is being created if not existant")
	expect.is_class_instance(new_component, TestComponent, "New component is of the registered class")
	expect.is_equal(gameObject.get_component("Test"), new_component, "Component was added to the game object")

func test_get_returns_null_if_component_class_was_not_registered():
	var new_component = gameObject.get_component("Test")
	expect.is_equal(new_component, null, "Null returned for unregistered components")

func test_get_operator_returns_existing_component():
	var test_component = TestComponent.new()
	gameObject.components["Test"] = test_component
	expect.is_equal(gameObject.Test, test_component, "Expected GameObject.Test to return the correct component")
	

func test_get_operator_creates_new_component_and_allows_access():
	gameWorld.components["Test"] = TestComponent
	(gameObject.Test as TestComponent).test = 5
	var new_component = gameObject.Test
	expect.is_equal(new_component.test, gameObject.Test.test, "Value of component can be set.")
