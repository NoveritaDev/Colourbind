extends Node

const LEVEL_FOLDERS := [
	"res://scenes/levels/tutorials/",
	"res://scenes/levels/hue/",
	"res://scenes/levels/"
]
const LEVEL_SELECT := "res://scenes/ui/level_select.tscn"

var levels: Array[String] = []
var current := 0
var sections: Array[Dictionary] = []

func _ready() -> void:
	for folder in LEVEL_FOLDERS:
		var files: Array[String] = []
		for file in ResourceLoader.list_directory(folder):
			if file.ends_with(".tscn"):
				files.append(file)
		var section := {"name": folder.trim_suffix("/").get_file(), "indices": []}
		for file in files:
			section["indices"].append(levels.size())
			levels.append(folder + file)
		if not section["indices"].is_empty():
			sections.append(section)

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
