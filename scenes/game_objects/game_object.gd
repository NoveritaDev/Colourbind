class_name GameObject
extends Node2D

static var GRID : Grid

enum OBJ_COLOR {
	NONE,
	COLOUR_1,
	COLOUR_2,
	COLOUR_3,
	COLOUR_4
}

@export var color : OBJ_COLOR

func _ready() -> void:
	pass
