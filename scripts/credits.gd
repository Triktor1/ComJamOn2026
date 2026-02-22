extends Control


@export var back_button:Button
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	back_button.pressed.connect(_go_back)

func _go_back():
	get_tree().change_scene_to_file("res://escenas/mainMenu.tscn")
