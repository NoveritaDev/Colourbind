extends CanvasLayer

@onready var settings_menu: Control = $Control/SettingsMenu

var won := false

func _ready() -> void:
	if is_instance_valid(GameObject.GRID):
		GameObject.GRID.s_level_won.connect(_on_level_won)

# Cannot close menu when the level is completed
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") and settings_menu.visible and not won:
		close_settings()

func _on_level_won() -> void:
	won = true
	open_settings()

func open_settings() -> void:
	settings_menu.show()
	get_tree().paused = true

func close_settings() -> void:
	settings_menu.hide()
	get_tree().paused = false

func _on_settings_button_pressed() -> void:
	open_settings()

func _on_settings_menu_restart_pressed() -> void:
	LevelManager.restart()

func _on_settings_menu_home_pressed() -> void:
	LevelManager.go_home()

func _on_settings_menu_next_level_pressed() -> void:
	LevelManager.next_level()
