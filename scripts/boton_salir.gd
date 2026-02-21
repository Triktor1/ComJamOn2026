extends BaseButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(_exitGame)

func _exitGame() -> void:
	get_tree().quit()
	AudioManager.stop()
