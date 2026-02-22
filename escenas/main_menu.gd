extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !AudioManager.is_playing():
		AudioManager.play("Main")
