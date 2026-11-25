extends Control

@onready var sections_box: VBoxContainer = %Sections

func _ready() -> void:
	for section in LevelManager.sections:
		var row := HBoxContainer.new()
		sections_box.add_child(row)
		var label := Label.new()
		label.text = section["name"].capitalize()
		label.custom_minimum_size = Vector2(120, 0)
		label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		row.add_child(label)
		for n in section["indices"].size():
			var button := Button.new()
			button.text = str(n + 1)
			button.custom_minimum_size = Vector2(64, 64)
			button.pressed.connect(LevelManager.load_level.bind(section["indices"][n]))
			row.add_child(button)
