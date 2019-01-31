extends "res://addons/gut/test.gd"

const GameWorld = preload("res://addons/gcs/gameWorld.gd")
const GameObject = preload("res://addons/gcs/gameObject.gd")
const GameSystem = preload("res://addons/gcs/gameSystem.gd")

var world
var map

func before_each():
    map = Node.new()
    world = GameWorld.new()
    map.add_child(world)
    