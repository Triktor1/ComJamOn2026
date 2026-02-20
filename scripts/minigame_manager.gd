extends Node
class_name MiniGameManager

@export var isWining = true
@export var time = 8.0

var end = false

var timer = 0.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer += delta
	if timer >= time and !end:
		end = true
		if (isWining):
			GameManager._state_win()
		else:
			GameManager._state_lose()
		print(isWining)

func changeWin(win:bool):
	isWining = win
