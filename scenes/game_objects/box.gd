class_name Pushable
extends GameObject

static var MAX_PUSH_COUNT = 1 # -1 means infinite boxes

@export var lms_tint: Vector3 = Vector3(1.0, 1.0, 1.0):
	set(value):
		lms_tint = value
		_update_tint()
@export var override_tint: bool = false:
	set(value):
		override_tint = value
		_update_tint()

@onready var sprite: Sprite2D = $s

func _update_tint() -> void:
	if is_instance_valid(sprite):
		if override_tint:
			sprite.set_instance_shader_parameter("tint", lms_tint)
			sprite.set_instance_shader_parameter("pattern_index", 0)
		else:
			sprite.set_instance_shader_parameter("tint", color_dict[color])
			sprite.set_instance_shader_parameter("pattern_index", pattern_dict[color])

func _ready() -> void:
	super._ready()
	if color == OBJ_COLOR.NONE:
		print("This box has no color, is that on purpose?")
	_update_tint()
