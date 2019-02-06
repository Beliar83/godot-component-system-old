extends "res://addons/gut/test.gd"

var gameWorld : BaseGameWorld;
var system : GameSystem

func before_each():
	gameWorld = GameWorld.new()
	system = GameSystem.new(gameWorld)

func test_game_system_is_in_world():
	gut.p("Test started")
	assert_has(gameWorld.systems, system)
	gut.p("Test ended")
