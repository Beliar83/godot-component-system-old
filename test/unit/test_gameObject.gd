extends "res://addons/gut/test.gd"

const Components = preload("res://addons/gcs/gameObject.gd")
const TestComponent = preload("res://test/unit/testComponent.gd")

var components;

func before_each():
	components = Components.new()
	
func test_has_returns_true_on_existing_component():
	gut.p("Test started")
	var test_component = TestComponent.new()
	components.components["Test"] = test_component
	assert_true(components.has_component("Test"), "Expected has_component to return true")
	gut.p("Test ended")

func test_has_returns_false_for_non_existing_component():
	gut.p("Test started")
	assert_false(components.has_component("Test"), "Expected has_component to return false")
	gut.p("Test ended")

func test_get_returns_existing_component():
	gut.p("Test started")
	var test_component = TestComponent.new()
	components.components["Test"] = test_component
	assert_eq(components.get_component("Test"), test_component, "Expected get_component to return the correct component")
	gut.p("Test ended")

func test_get_returns_null_for_non_existing_component():
	gut.p("Test started")
	assert_eq(components.get_component("Test"), null, "Expected get_component to return null")
	gut.p("Test ended")
	
func test_create_and_add_adds_non_existing_component():
	gut.p("Test started")
	var component = components.create_and_add_component(TestComponent, "Test")
	assert_ne(component, null, "Expected non null return value")
	assert_eq(components.components["Test"], component, "Expected components to have the new component")
	gut.p("Test ended")

func test_create_and_add_does_not_add_if_component_already_exists():
	gut.p("Test started")
	var test_component = TestComponent.new()
	components.components["Test"] = test_component
	var component = components.create_and_add_component(TestComponent, "Test")
	assert_eq(component, null, "Expected null return value")
	assert_eq(components.components["Test"], test_component, "Expected components to have the old component")
	gut.p("Test ended")

func test_get_operator_returns_existing_component():
	gut.p("Test started")
	var test_component = TestComponent.new()
	components.components["Test"] = test_component
	assert_eq(components.Test, test_component, "Expected GameObject.Test to return the correct component")
	gut.p("Test ended")