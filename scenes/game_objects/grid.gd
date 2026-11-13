extends Node2D

# Grid Object that levels are based in
# Indexed (x, y)
# (0, 0) Is the top left corner, +x is right, +y is down

var grid_width : int
var grid_height : int

class Cell:
	var nodes: Array[Node2D]

var grid : Array[Cell]

func index(x: int, y: int) -> int:
	return x * grid_height + y

func get_at(x: int, y: int) -> Cell:
	return grid[index(x, y)]

func place_at(obj: Node2D, x: int, y: int) -> void:
	grid[index(x, y)].nodes.append(obj)

func remove_at(obj: Node2D, x: int, y: int) -> void:
	grid[index(x, y)].nodes.erase(obj)

func world_to_grid(worldpos: Vector2) -> Vector2i: # Needs fixing when actually calibrated
	return Vector2i(roundi(worldpos.x), roundi(worldpos.y))

func grid_to_world(x: int, y: int) -> Vector2: # Needs fixing when actually calibrate
	return Vector2(x, y)

func move(obj: Node2D, x: int, y: int) -> void:
	var obj_pos := world_to_grid(obj.position)
	remove_at(obj, obj_pos.x, obj_pos.y)
	place_at(obj, x, y)
	obj.position = grid_to_world(x, y)


func load_grid_objs() -> void:
	for child in get_children():
		if child is Node2D:
			var pos := world_to_grid(child.position)
			place_at(child, pos.x, pos.y)
			child.position = pos
