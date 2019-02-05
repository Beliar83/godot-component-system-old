extends "res://addons/gut/test.gd"

const GameWorld = preload("res://addons/gcs/gameWorld.gd")
const GameObject = preload("res://addons/gcs/gameObject.gd")
const TestComponent = preload("res://test/unit/testComponent.gd")

var gameWorld : GameWorld;
var gameObject : GameObject;

func before_each():
	gameWorld = GameWorld.new()
	gameObject = GameObject.new(gameWorld)
	
func test_game_object_is_in_world():
	gut.p("Test started")
	assert_has(gameWorld.game_objects.keys(), gameObject.id)
	assert_has(gameWorld.game_objects.values(), gameObject)
	gut.p("Test ended")

func test_has_returns_true_on_existing_component():
	gut.p("Test started")
	var test_component = TestComponent.new()
	gameObject.components["Test"] = test_component
	assert_true(gameObject.has_component("Test"), "Expected has_component to return true")
	gut.p("Test ended")

func test_has_returns_false_for_non_existing_component():
	gut.p("Test started")
	assert_false(gameObject.has_component("Test"), "Expected has_component to return false")
	gut.p("Test ended")

func test_get_returns_existing_component():
	gut.p("Test started")
	var test_component = TestComponent.new()
	gameObject.components["Test"] = test_component
	assert_eq(gameObject.get_component("Test"), test_component, "Expected get_component to return the correct component")
	gut.p("Test ended")

func test_get_creates_component_if_it_does_not_exist():
	gut.p("Test started")
	gameWorld.components["Test"] = TestComponent
	var new_component = gameObject.get_component("Test")
	assert_ne(new_component, null, "Expected get_component to return a new component")
	assert_is(new_component, TestComponent, "Expected new component to be of the registered class")
	assert_eq(gameObject.get_component("Test"), new_component, "Expected get_component to have added the component to its components")
	gut.p("Test ended")

func test_get_returns_null_if_component_class_was_not_registered():
	gut.p("Test started")
	var new_component = gameObject.get_component("Test")
	assert_eq(new_component, null, "Expected get_component to return null for unknown components")
	gut.p("Test ended")

func test_get_operator_returns_existing_component():
	gut.p("Test started")
	var test_component = TestComponent.new()
	gameObject.components["Test"] = test_component
	assert_eq(gameObject.Test, test_component, "Expected GameObject.Test to return the correct component")
	gut.p("Test ended")
	

func test_get_operator_creates_new_component_and_allows_access():
	gut.p("Test started")
	gameWorld.components["Test"] = TestComponent
	(gameObject.Test as TestComponent).test = 5
	gameObject.Test.modified = true
	var new_component = gameObject.Test
	assert_eq(new_component.test, gameObject.Test.test)
	assert_true(gameObject.Test.modified)
	gut.p("Test ended")