extends Node
class_name TestNode

var world
var tree

func _init():
	tree = TestTree.new()
	
func get_tree():
	return tree

func _process(delta):
	world._process(delta)
	
func _physics_process(delta):
	world._physics_process(delta)