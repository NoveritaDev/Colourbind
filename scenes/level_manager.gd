extends Node

const LEVELS_DIR := "res://scenes/levels/"
const LEVEL_SELECT := "res://scenes/ui/level_select.tscn"

var levels: Array[String] = []
var current := 0

func _ready() -> void:
	for file in ResourceLoader.list_directory(LEVELS_DIR):
		if file.ends_with(".tscn"):
			levels.append(LEVELS_DIR + file)
	levels.sort()

func load_level(index: int) -> void:
	current = index
	get_tree().paused = false
	get_tree().change_scene_to_file(levels[index])


func restart() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()


func next_level() -> void:
	if current + 1 < levels.size():
		load_level(current + 1)


func go_home() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(LEVEL_SELECT)
