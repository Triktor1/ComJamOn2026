extends TextureButton

@export var startScene: PackedScene

func _ready() -> void:
	pressed.connect(_endlessMode)

func _endlessMode() -> void:
	GameManager.endless = true
	AudioManager.stop()
	get_tree().change_scene_to_packed(startScene)
