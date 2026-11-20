class_name GameObject
extends Node2D

static var GRID : Grid

# List of colors, NONE is there for non-colored gameobjects
enum OBJ_COLOR { # We can add more colors, just this for now
	NONE,
	RED,
	BLUE,
	GREEN,
	CYAN,
	GREY,
	PINK
}

# Where color objects get mapped to actual colors
var color_dict : Dictionary[OBJ_COLOR, Color] = {
	OBJ_COLOR.NONE: Color(1,1,1),
	OBJ_COLOR.RED: Color(0.314,0.155,0.018),
	OBJ_COLOR.BLUE: Color(0.046500889, 0.086707664, 0.872632109),
	OBJ_COLOR.GREEN: Color(0.639540462, 0.757927085, 0.109446836),
	#these are hard to tell apart for protanopia
	OBJ_COLOR.CYAN: Color(0.392, 0.710, 0.690),
	OBJ_COLOR.GREY: Color(0.659, 0.663, 0.671),
	OBJ_COLOR.PINK: Color(0.847, 0.604, 0.651)
}

var pattern_dict : Dictionary[OBJ_COLOR, int] = {
	OBJ_COLOR.NONE: 0,
	OBJ_COLOR.RED: 0,
	OBJ_COLOR.BLUE: 1,
	OBJ_COLOR.GREEN: 2, # Change to other pattern
	
	OBJ_COLOR.CYAN: 0,
	OBJ_COLOR.GREY: 1,
	OBJ_COLOR.PINK: 2,
}

@export var color : OBJ_COLOR


func _ready() -> void:
	modulate = color_dict[color]
