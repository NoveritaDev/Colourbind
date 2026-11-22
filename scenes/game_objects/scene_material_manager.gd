extends Node

@export var colour_1: Material = null
@export var colour_2: Material = null
@export var colour_3: Material = null
var glint_index: int = 0
var max_index: int = 0

func find_all_game_objects(root: Node = get_tree().current_scene) -> Array[GameObject]:
	
	var results: Array[GameObject] = []

	if is_instance_of(root, GameObject):
		results.append(root)
		
	for child in root.get_children():
		results.append_array(find_all_game_objects(child))
		
	return results

func get_material(index: int) -> Material:
	if index == 1:
		return colour_1
	elif index == 2:
		return colour_2
	elif index == 3:
		return colour_3
	else:
		return null

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("cycle_glint_target"):
		var m: Material = get_material(glint_index)
		if m != null:
			m.set_shader_parameter("glint_intensity", 0.0)
		
		glint_index = (glint_index + 1) % (max_index + 1)
		
		m = get_material(glint_index)
		if m != null:
			m.set_shader_parameter("glint_intensity", 0.3)

func _ready() -> void:
	var all_game_objects = find_all_game_objects()
	for item in all_game_objects:
		if item.color == GameObject.OBJ_COLOR.COLOUR_1:
			item.material = colour_1
		elif item.color == GameObject.OBJ_COLOR.COLOUR_2:
			item.material = colour_2
		elif item.color == GameObject.OBJ_COLOR.COLOUR_3:
			item.material = colour_3
			
	max_index = 3
	if colour_3 == null:
		max_index = 2
	if colour_2 == null:
		max_index = 1
	if colour_1 == null:
		max_index = 0
