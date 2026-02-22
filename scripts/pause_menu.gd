extends Control

@export var cont_button:BaseButton
@export var main_button:BaseButton
@export var quit_button:BaseButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	cont_button.pressed.connect(_continue)
	main_button.pressed.connect(_main_menu)
	quit_button.pressed.connect(_quit)
	
	GameManager.pause_changed.connect(_show)


func _show(paused:bool):
	visible=true

func _continue():
	GameManager.toggle_pause()
	visible=false

func _main_menu():
	GameManager.paused = false; 
	get_tree().change_scene_to_file("res://escenas/mainMenu.tscn")
	
func _quit():
	get_tree().quit()	
