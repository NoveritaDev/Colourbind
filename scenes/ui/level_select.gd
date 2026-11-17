extends Control

@onready var level_grid: GridContainer = %LevelGrid

func _ready() -> void:
	for i in LevelManager.levels.size():
		var button := Button.new()
		#button.text = str(i + 1)
		button.text = LevelManager.levels[i].get_file()
		button.custom_minimum_size = Vector2(64, 64)
		button.pressed.connect(LevelManager.load_level.bind(i))
		level_grid.add_child(button)
