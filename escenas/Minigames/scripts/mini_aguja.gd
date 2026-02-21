extends Node2D

@export var minigame_manager:MiniGameManager
@export var needle:Node2D
@export var win_area:Area2D
@export var lose_area:Area2D

@export var speed:float=12.0

var limit:float=300.0
var dir:int=-1

var used:bool=false

func _ready() -> void:
	needle.get_child(0).area_entered.connect(_on_col)

func _process(delta: float) -> void:
	if not used:
		needle.global_position.y+=speed*dir*delta
		if needle.global_position.y<=-limit:
			dir=1
		elif needle.global_position.y>=limit:
			dir=-1
	else:
		needle.global_position.x+=speed*delta

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Space"):
		used=true

func _on_col(area:Area2D):
	if area==win_area:
		print("win")
		minigame_manager.changeWin(true)
	elif area==lose_area:
		print("loose")
		minigame_manager.changeWin(false)
	
