extends CanvasLayer

@onready var cont_button:Button=$ContinueButton
@onready var main_button:Button=$MainMenuButton
@onready var quit_button:Button=$QuitButton

@export var main_menu_scene:PackedScene


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	visible = false
	
	cont_button.pressed.connect(_continue)
	main_button.pressed.connect(_main_menu)
	quit_button.pressed.connect(_quit)

func _process(delta):
	visible = GameManager.paused
	
func _continue():
	GameManager.toogle_pause()

func _main_menu():
	GameManager.paused = false; 
	get_tree().change_scene_to_packed(main_menu_scene)
	
func _quit():
	get_tree().quit()	
