extends Node

@export var isWining = true
@export var time = 8.0 

var end = false

var timer = 0.0

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer += delta
	
	if timer >= time and !end:
		end = true
		if (isWining):
			GameManager._state_win()
		else:
			GameManager._state_lose()

func changeWin(bool):
	isWining = bool
