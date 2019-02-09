extends GameWorld

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var demo_object : GameObject
var time : float

# Called when the node enters the scene tree for the first time.
func _ready():
	components["position"] = PositionComponent
	MovementSystem.new(self)
	demo_object = GameObject.new(self)
	demo_object.position.node = $"DemoNode"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	if time > 1:
		print(demo_object.position.vector)
		time -= 1

func _physics_process(delta):
	$"DemoNode".position.x += 10 * delta
	$"DemoNode".position.y += 10 * delta

func _input(event):
		if event is InputEventMouseButton:
			if !event.pressed:
				demo_object.position.vector = event.position
				demo_object.position.modified = true
