extends Control

@onready var cont_button:Button=$ContinueButton
@onready var main_button:Button=$MainMenuButton
@onready var quit_button:Button=$QuitButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cont_button.pressed.connect(_continue)
	main_button.pressed.connect(_main_menu)
	quit_button.pressed.connect(_quit)

func _continue():
	visible=false
	get_tree().paused=!get_tree().paused

func _main_menu():
	get_tree().change_scene_to_file("res://mainMenu.tscn")

func _quit():
	get_tree().quit()
