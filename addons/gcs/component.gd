extends Resource
class_name Component

export(bool) var modified = false

func _ready():
	pass

func get_serializable_fields() -> Array:
	return _get_serializable_fields()

func _get_serializable_fields() -> Array:
	return Array()
