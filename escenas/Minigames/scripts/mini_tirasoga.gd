extends Node2D

@export var tirasoga:Node2D
@export var lose_area:Area2D
@export var win_area:Area2D
@export var minigame_manager:MiniGameManager

func _ready() -> void:
	tirasoga.get_child(0).area_entered.connect(_area_reached)


func _area_reached(area:Area2D):
	if area==lose_area:
		minigame_manager.changeWin(false)
	elif area==win_area:
		minigame_manager.changeWin(true)
