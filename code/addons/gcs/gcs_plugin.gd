tool
extends EditorPlugin

func _enter_tree():
	# Initialization of the plugin goes here
	add_custom_type("GameWorld", "Node", preload("gameWorld.gd"), preload("res://addons/gcs/icon.png"))

func _exit_tree():
	# Clean-up of the plugin goes here
	pass