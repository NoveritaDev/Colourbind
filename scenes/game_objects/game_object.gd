class_name GameObject
extends Node2D

static var GRID : Grid

# List of colors, NONE is there for non-colored gameobjects
enum OBJ_COLOR { # We can add more colors, just this for now
	NONE,
	RED,
	BLUE,
	GREEN
}

# Where color objects get mapped to actual colors
var color_dict : Dictionary[OBJ_COLOR, Color] = {
	OBJ_COLOR.NONE: Color(1,1,1),
	OBJ_COLOR.RED: Color(0.314,0.155,0.018),
	OBJ_COLOR.BLUE: Color(0.046500889, 0.086707664, 0.872632109),
	OBJ_COLOR.GREEN: Color(0.639540462, 0.757927085, 0.109446836)
}

@export var color : OBJ_COLOR


func _ready() -> void:
	modulate = color_dict[color]
