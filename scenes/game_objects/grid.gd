class_name Grid
extends Node2D

# Grid Object that levels are based in
# Indexed (x, y)
# (0, 0) Is the top left corner, +x is right, +y is down

@export_range(1, 1024) var grid_width : int = 16
@export_range(1, 1024) var grid_height : int = 16
@export_range(1, 256) var tile_size : int = 64
@onready var tile_offset := tile_size / 2

class Cell:
	var objs: Array[GameObject]
	var stop: bool

var grid : Array[Cell]

# Converts positions to 1D Array format
func index(pos: Vector2i) -> int:
	if pos.x < 0 || pos.x >= grid_width || pos.y < 0 || pos.y >= grid_height:
		print("Indexing outside of bounds, returning 0")
		return 0
	return pos.x + pos.y * grid_width

# Returns the Cell object located at the given position
func get_at(pos: Vector2i) -> Cell:
	if pos.x < 0 || pos.x >= grid_width || pos.y < 0 || pos.y >= grid_height:
		print("Getting from outside of bounds, returning null")
		return null
	return grid[index(pos)]

# Adds the given object to the cell located at the given position
func place_at(obj: GameObject, pos: Vector2i) -> void:
	if pos.x < 0 || pos.x >= grid_width || pos.y < 0 || pos.y >= grid_height:
		print("Placing outside of bounds, returning")
		print(pos)
		return
	grid[index(pos)].objs.append(obj)

# Removes the given object from the cell located at the given position
func remove_at(obj: GameObject, pos: Vector2i) -> void:
	if pos.x < 0 || pos.x >= grid_width || pos.y < 0 || pos.y >= grid_height:
		print("Removing from outside of bounds, returning")
	grid[index(pos)].objs.erase(obj)

# Translates (local to grid) world coordinates to grid coordinates
func world_to_grid(world_pos: Vector2) -> Vector2i: # Needs fixing when actually calibrated
	return Vector2i(roundi((world_pos.x - tile_offset) / 64 ), 
					roundi((world_pos.y - tile_offset) / 64 ))

# Translates grid coordinates to (local to grid) world coordinates
func grid_to_world(pos: Vector2i) -> Vector2: # Needs fixing when actually calibrate
	return Vector2(pos.x, pos.y) * tile_size + Vector2(tile_offset, tile_offset)

# Transport an object from one grid cell to another
func move(obj: GameObject, new_pos: Vector2i) -> void:
	if new_pos.x < 0 || new_pos.x >= grid_width || new_pos.y < 0 || new_pos.y >= grid_height:
		print("Attempting to move object outside of bounds, returning")
		return
	
	var obj_pos := world_to_grid(obj.position)
	remove_at(obj, obj_pos)
	place_at(obj, new_pos)
	obj.position = grid_to_world(new_pos)

# Recursive function to handle pushing "trains" of blocks
func push(pos: Vector2i, dir: Vector2i) -> bool:
	print("current pos %s" % pos) #**
	print("next pos %s" % (pos + dir)) #**
	if dir.length() != 1:
		print("Given push direction does not have a magnitude of 1")
		return false
	
	if get_at(pos + dir) == null || get_at(pos + dir).stop:
		print("Could not push, wall at %s" % (pos + dir))
		return false
	
	var pushable_at_pos := false
	for obj in get_at(pos + dir).objs:
		if obj.pushable:
			pushable_at_pos = true
			break
	
	if pushable_at_pos && !push(pos + dir, dir):
		return false
	
	for obj in get_at(pos).objs:
		print("?") #**
		if obj.pushable:
			print(obj) #**
			print(pos + dir)
			move(obj, pos + dir)
	
	return true
	
	# Recursively check if next tile is pushable to
	# Any empty space cascades back pushing all objects forward
	# Any blocked space cascades back halting all object movement
	# Starts at player position and moves to the last position before a stop cell

func load_grid() -> void:
	for i in range(grid_width * grid_height):
		grid.append(Cell.new())

# Loads all children of the grid object into the grid array
func load_grid_objs() -> void:
	for child in get_children():
		if child is GameObject:
			var pos := world_to_grid(child.position)
			place_at(child, pos)
			child.position = grid_to_world(pos) # Move the object to the nearest grid position


func _ready() -> void:
	GameObject.GRID = self
	$Background.size = Vector2i(grid_width * tile_size, grid_height * tile_size)
	$Background.position = position
	load_grid()
	load_grid_objs()


func test() -> void:
	for i in range(grid_width):
		for j in range(grid_height):
			if i == 0 || j == 0:
				get_at(Vector2i(i, j)).stop = true
