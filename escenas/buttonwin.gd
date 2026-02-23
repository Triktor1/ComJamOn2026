extends TextureButton

@export var startScene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(onclick)

func onclick():
	get_tree().change_scene_to_packed(startScene)
