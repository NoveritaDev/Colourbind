extends CanvasLayer

@onready var filter_rect: ColorRect = $ColorRect
var current_mode: int = 0
const MODE_NAMES := ["Typical", "Protanopia", "Deuteranopia", "Tritanopia", "Achromatopsia", "S-Cone Isolation"]

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_M:
			current_mode = (current_mode + 1) % MODE_NAMES.size()
			var mat := filter_rect.material as ShaderMaterial
			if mat:
				mat.set_shader_parameter("cvd_type", current_mode)
				
