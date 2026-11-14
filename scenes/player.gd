class_name Player
extends GameObject


func move(dir: Vector2i) -> void:
	var pos := GRID.world_to_grid(position)
	if GRID.push(pos, dir):
		GRID.move(self, pos + dir)

	 
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("move_up"):
		move(Vector2i.UP)
	if Input.is_action_just_pressed("move_down"):
		move(Vector2i.DOWN)
	if Input.is_action_just_pressed("move_left"):
		move(Vector2i.LEFT)
	if Input.is_action_just_pressed("move_right"):
		move(Vector2i.RIGHT)
