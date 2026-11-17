extends Control

signal restart_pressed
signal home_pressed
signal next_level_pressed

func _on_restart_button_pressed() -> void:
	restart_pressed.emit()


func _on_home_button_pressed() -> void:
	home_pressed.emit()


func _on_next_level_button_pressed() -> void:
	next_level_pressed.emit()
