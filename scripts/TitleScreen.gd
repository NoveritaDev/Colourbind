extends Control

@onready var start_button: Button = $Start
@onready var lvl_button: Button = $"Level Select"
@onready var settings_button: Button = $Settings
@onready var title_theme: AudioStreamPlayer2D = $TitleTheme
@onready var select_sound: AudioStreamPlayer2D = $SelectSound

func _ready() -> void:
	title_theme.play(1.0)

func _on_start_pressed() -> void:
	# CHANGE TO INTRO CUTSCENE
	start_button.disabled = true
	# turn off cvd
	Globals.stop_cvd_cycle = true
	
	# Delay sound effect before loading next scene
	title_theme.stop()
	select_sound.play()
	await get_tree().create_timer(2.0).timeout
	select_sound.stop()
	get_tree().change_scene_to_file("res://scenes/levels/tutorials/tutorial_1.tscn")

func _on_settings_pressed() -> void:
	settings_button.disabled = true
	# turn off cvd
	Globals.stop_cvd_cycle = true
	
	# Delay sound effect before loading next scene
	title_theme.stop()
	select_sound.play()
	await get_tree().create_timer(2.0).timeout
	select_sound.stop()
	get_tree().change_scene_to_file("res://scenes/ui/settings_menu.tscn")

func _on_level_select_pressed() -> void:
	lvl_button.disabled = true
	# turn off cvd
	Globals.stop_cvd_cycle = true
	
	# Delay sound effect before loading next scene
	title_theme.stop()
	select_sound.play()
	await get_tree().create_timer(2.0).timeout
	select_sound.stop()
	get_tree().change_scene_to_file("res://scenes/ui/level_select.tscn")
