extends Control

@export var main_menu_button:BaseButton
@export var label_score:Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main_menu_button.pressed.connect(_go_to_main_menu)
	label_score.text=str(GameManager.get_mini_count())


func _go_to_main_menu():
	get_tree().change_scene_to_file("res://escenas/mainMenu.tscn")
