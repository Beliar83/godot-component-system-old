extends Object
class_name TestTree

signal idle_frame

func emit_idle_frame():
	print("idle_frame")
	emit_signal("idle_frame")
