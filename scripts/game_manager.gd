extends Node

@export var minigames: Array[PackedScene]
@export var boss_minigames: Array[PackedScene]

@export var endless: bool = false
@export var boss_interval: int = 15
@export var speedup_interval: int = 2

@export var max_speed: float = 3.0
@export var speed_increment: float = 0.15

var current_speed: float = 1.0
var current_pitch: float = 1.0
var lives: int = 4
var minigame_count: int = 0

var shuffled_minigames: Array[PackedScene] = []
var current_minigame_index: int = 0
var current_minigame: Node
var boss_time: bool = false
var in_minigame: bool = false

# SEÑALES
signal comence
signal minigame_start
signal win
signal lost
signal speedup
signal boss_intro
signal show_intro(text: String, control_type: int)
signal UIocult
signal minigame_end

enum ControlType {
	WASD,
	ZX,
	SPACE
}

# ESTADO 0 START
func _state_start():
	_shuffle_minigames()
	lives = 4
	minigame_count = 0
	current_speed = 1.0
	current_pitch = 1.0
	in_minigame = false
	AudioManager.play("GANAR", current_speed)
	
	comence.emit()
	await get_tree().create_timer(4.3).timeout
	_state_minigame_intro()

# ESTADO 1 COMIENZA MINIJUEGO
func _state_minigame_intro():
	boss_time = false
	minigame_count += 1
	AudioManager.play("NEXT", current_speed)
	
	minigame_start.emit()
	in_minigame = true
	
	_emit_intro_data()
	await get_tree().create_timer(2.7).timeout
	
	UIocult.emit()
	_fade_out_overlay()
	_load_next_minigame()


func _emit_intro_data():
	if current_minigame_index >= shuffled_minigames.size():
		_shuffle_minigames()
	
	var scene: PackedScene = shuffled_minigames[current_minigame_index]
	var inst = scene.instantiate()

	var text: String = inst.instr
	var control: int = inst.control_type

	inst.queue_free()

	show_intro.emit(text, control)

# ESTADO 2 SE GANA MINIJEUEGO
func _state_win():
	minigame_end.emit()
	AudioManager.play("GANAR", current_speed)
	win.emit()
	in_minigame = false
	_cleanup_minigame()
	await get_tree().create_timer(4.3).timeout
	if boss_time:
		if not endless:
			_state_boss_intro()
			return
		else:
			lives += 1
	if _speedup():
		_state_speed_up()
		return
	elif _boss_time():
		_state_boss_intro()
		return
	else:
		_state_minigame_intro()

# ESTADO 3 SE PIERDE M9INIJUEGO
func _state_lose():
	minigame_end.emit()
	lives -= 1
	lost.emit()
	AudioManager.play("PERDIDO", current_speed)
	in_minigame = false
	_cleanup_minigame()
	await get_tree().create_timer(2.7).timeout
	if lives <= 0:
		_state_game_over()
		return
	if boss_time:
		if endless:
			boss_time = false
			_state_minigame_intro()
		else:
			_state_boss_intro()
			return
		return
	if _speedup():
		_state_speed_up()
		return
	else:
		_state_minigame_intro()
		return

func _state_game_over():
	current_speed = 1.0
	current_pitch = 1.0
	_apply_speed()
	AudioManager.play("GAMEOVER", current_speed)
	await get_tree().create_timer(2.4).timeout

func _state_speed_up():
	AudioManager.play("SPEEDUP", current_speed)
	speedup.emit()
	current_speed = min(current_speed + speed_increment, max_speed)
	current_pitch = min(current_pitch + speed_increment, max_speed)
	_apply_speed()
	await get_tree().create_timer(1.4).timeout
	if _boss_time():
		_state_boss_intro()
	else:
		_state_minigame_intro()

func _state_boss_intro():
	boss_time = true
	AudioManager.play("BOSSTIME", current_speed)     
	_load_random_boss()
	await get_tree().create_timer(2.4).timeout
	boss_intro.emit()

func _state_results():
	pass
func _state_final_victory():
	return
	
func _shuffle_minigames():
	shuffled_minigames = minigames.duplicate()
	shuffled_minigames.shuffle()
	current_minigame_index = 0
	
func _load_next_minigame():	
	if current_minigame_index >= shuffled_minigames.size():
		_shuffle_minigames()
	var scene: PackedScene = shuffled_minigames[current_minigame_index]
	current_minigame_index += 1
	_spawn_minigame(scene)

func _load_random_boss():
	return

func _spawn_minigame(scene: PackedScene):	
	current_minigame = scene.instantiate()
	add_child(current_minigame)
	move_child(current_minigame, 0)

func _speedup() -> bool:
	return (minigame_count % speedup_interval) == 0

func _boss_time() -> bool:
	return false

func _apply_speed():
	Engine.time_scale = current_speed

func _fade_out_overlay():
	return
	
func _fade_in_overlay():
	return
	
func _cleanup_minigame():
	if current_minigame:
		current_minigame.queue_free()
		current_minigame = null

func get_mini_count() -> int:
	return minigame_count
