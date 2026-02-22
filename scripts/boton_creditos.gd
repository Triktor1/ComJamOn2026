extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(_go_to_credits)

func _go_to_credits():
	get_tree().change_scene_to_file("res://escenas/credits.tscn")
