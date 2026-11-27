extends CanvasLayer

@onready var filter_rect: ColorRect = $ColorRect
@onready var timer: Timer = $Timer
var current_mode: int = 0
const MODE_NAMES := ["Typical", "Protanopia", "Deuteranopia", "Tritanopia", "Achromatopsia", "S-Cone Isolation"]

func _ready() -> void:
	while true:
		await get_tree().create_timer(1.5).timeout
		cvd_change()

func cvd_change() -> void:
	current_mode = (current_mode + 1) % MODE_NAMES.size()
	var mat := filter_rect.material as ShaderMaterial
	if mat:
		if current_mode == 0:
			# normal vision
			mat.set_shader_parameter("cvd_type", 0)
		elif current_mode == 1:
			# protanopia
			mat.set_shader_parameter("cvd_type", 1)
		elif current_mode == 2:
			# deutronomoa
			mat.set_shader_parameter("cvd_type", 2)
		elif current_mode == 3:
			# tritanopia
			mat.set_shader_parameter("cvd_type", 3)
		else:
			# achromatism
			mat.set_shader_parameter("cvd_type", 4)
			current_mode += 1
