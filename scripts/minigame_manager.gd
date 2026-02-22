extends Node
class_name MiniGameManager

signal countdown_start
signal countdown_second
signal countdown_final

@export var isWining: bool = true
@export var time: float = 8.0
@export var endEarlyIfWon: bool = false
@export var endEarlyIfLost: bool = false

var end: bool = false
var timer: float = 0.0

var sent_start: bool = false
var sent_second: bool = false
var sent_final: bool = false

func _process(delta: float) -> void:
	if end:
		return
	
	timer += delta
	var remaining: float = time - timer
	
	# Cuando quedan 4.5 segundos
	if not sent_start and remaining <= 4.5 and remaining > 0.0:
		sent_start = true
		countdown_start.emit()
	
	var third: float = 4.5 / 3.0
	
	# Segundo tercio
	if sent_start and not sent_second and remaining <= 4.5 - third and remaining > 0.0:
		sent_second = true
		countdown_second.emit()
	
	# Último tercio
	if sent_second and not sent_final and remaining <= 4.5 - (third * 2.0) and remaining > 0.0:
		sent_final = true
		countdown_final.emit()
	
	if timer >= time:
		end = true
		if isWining:
			GameManager._state_win()
		else:
			GameManager._state_lose()

func changeWin(win: bool) -> void:
	if end:
		return
	
	isWining = win
	
	if endEarlyIfLost and not isWining:
		end = true
		await get_tree().create_timer(1.0).timeout
		GameManager._state_lose()
	
	elif endEarlyIfWon and isWining:
		end = true
		await get_tree().create_timer(1.0).timeout
		GameManager._state_win()
