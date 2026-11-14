class_name Pushable
extends GameObject

static var MAX_PUSH_COUNT = 2 # -1 means infinite boxes

func _ready() -> void:
	super._ready()
	if color == OBJ_COLOR.NONE:
		print("This box has no color, is that on purpose?")
