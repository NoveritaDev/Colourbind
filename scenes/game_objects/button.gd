class_name PushButton
extends GameObject

var activated : bool

signal s_activation(change: bool)

func press() -> void:
	activated = true
	s_activation.emit(activated)
	print("Pressed!") #**

func depress() -> void:
	activated = false
	s_activation.emit(activated)
	print("Depressed!") #**

func check_for_box() -> void:
	if color == OBJ_COLOR.NONE:
		return
	
	var cell := GRID.get_at(GRID.world_to_grid(position))
	
	var obj_found := false
	for obj in cell.objs:
		if obj is Pushable && obj.color == color:
			if !activated:
				press()
			obj_found = true
			break
	
	if !obj_found && activated:
		depress()


func _ready() -> void:
	super._ready()
	if color == OBJ_COLOR.NONE:
		print("This button has no color, is that on purpose?")
	
	GRID.s_box_moved.connect(check_for_box)
