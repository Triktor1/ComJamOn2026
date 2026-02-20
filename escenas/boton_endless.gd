extends TextureButton


func _ready() -> void:
	pressed.connect(_endlessMode)

func _endlessMode() -> void:
	pass
