extends Node2D

@export var speed:float=10.0
@export var jump:float=5.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position.x-=speed*delta;

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Space"):
		global_position.x+=jump
