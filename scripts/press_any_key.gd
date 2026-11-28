extends Control

# Called when the node enters the scene tree for the first time.
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		get_tree().change_scene_to_file("res://scenes/ui/title_screen.tscn")

	elif event is InputEventMouseButton and event.pressed:
		get_tree().change_scene_to_file("res://scenes/ui/title_screen.tscn")
