class_name GameObject
extends Node2D

static var GRID : Grid

enum OBJ_COLOR { # We can add more colors, just this for now
	NONE,
	RED,
	BLUE,
	GREEN
}

var color_dict : Dictionary[OBJ_COLOR, Color] = {
	OBJ_COLOR.NONE: Color.WHITE,
	OBJ_COLOR.RED: Color.RED,
	OBJ_COLOR.BLUE: Color.BLUE,
	OBJ_COLOR.GREEN: Color.GREEN
}

@export var color : OBJ_COLOR


func _ready() -> void:
	modulate = color_dict[color]
	print(modulate)
