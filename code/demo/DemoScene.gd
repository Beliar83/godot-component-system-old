extends Node2D

var demo_object : GameObject
var demo_world : GameWorld

# Called when the node enters the scene tree for the first time.
func _ready():
	demo_world = GameWorld.new()
	demo_world.components["position"] = PositionComponent
	demo_world.root_node = self
	MovementSystem.new(demo_world)
	if demo_world.load("res://demo_object.tres"):
		demo_object = demo_world.DemoObject
	else:
		demo_world.DemoObject = GameObject.new()
		demo_object = demo_world.DemoObject
		demo_object.position.node = get_path_to($"DemoNode")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	demo_world._process(delta)

func _physics_process(delta):
	demo_object.position.vector.x += 10 * delta
	demo_object.position.vector.y += 10 * delta
	demo_world._physics_process(delta)

func _input(event):
		if event is InputEventMouseButton:
			if !event.pressed:
				demo_object.position.vector = event.position
		if event is InputEventKey:
			var key_event = event as InputEventKey
			if key_event.scancode == KEY_S:
					demo_world.save("res://demo_object.tres")
