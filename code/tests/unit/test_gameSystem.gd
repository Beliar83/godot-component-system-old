extends WATTest

var gameWorld : BaseGameWorld;
var system : GameSystem

func start():
	gameWorld = GameWorld.new()
	system = GameSystem.new(gameWorld)

func test_game_system_is_in_world():
	expect.has(system, gameWorld.systems, "System was added to the world")
