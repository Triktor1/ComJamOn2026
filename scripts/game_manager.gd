extends Node

@export var minigames: Array[PackedScene]
@export var boss_minigames: Array[PackedScene]

@export var results: PackedScene
@export var win_screen: PackedScene

@export var endless: bool = false
@export var boss_interval: int = 15
@export var speedup_interval: int = 5

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
var paused: bool = false

# SEÑALES
signal comence
signal minigame_start
signal win
signal lost
signal speedup
signal boss_intro
signal show_intro(text: String, control_type: int)
signal UIocult
signal pause_changed(is_paused: bool)
signal minigame_end
signal transition_start
signal heal

signal cat_comence
signal cat_win
signal cat_loose
signal cat_speedup
signal cat_intro
signal cat_victory
signal cat_boss

enum ControlType {
	WASD,
	ZX,
	SPACE
}

# ESTADO 0 START
func _state_start():
	cat_comence.emit()
	_shuffle_minigames()
	lives = 4
	minigame_count = 0
	current_speed = 1.0
	current_pitch = 1.0
	in_minigame = false
	AudioManager.play("GANAR", current_speed)
	
	comence.emit()
	await get_tree().create_timer(4.45).timeout
	_state_minigame_intro()

# ESTADO 1 COMIENZA MINIJUEGO
func _state_minigame_intro():
	cat_intro.emit()
	boss_time = false
	minigame_count += 1
	AudioManager.play("NEXT", current_speed)
	
	minigame_start.emit()
	in_minigame = true
	
	_emit_intro_data(false)
	await get_tree().create_timer(2.55).timeout
	transition_start.emit()
	UIocult.emit()
	_fade_out_overlay()
	_load_next_minigame()

# ESTADO 2 SE GANA MINIJEUEGO
func _state_win():
	cat_win.emit()
	minigame_end.emit()
	AudioManager.play("GANAR", current_speed)
	win.emit()
	in_minigame = false
	_cleanup_minigame()
	await get_tree().create_timer(4.5).timeout
	if boss_time:
		if not endless:
			_state_final_victory()
			return
		else:
			lives += 1
			heal.emit()
	if _speedup():
		_state_speed_up()
		return
	elif _boss_time():
		_state_boss_intro()
		return
	else:
		_state_minigame_intro()

# ESTADO 3 SE PIERDE MINIJUEGO
func _state_lose():
	cat_loose.emit()
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
	elif _boss_time():
		_state_boss_intro()
		return
	if _speedup():
		_state_speed_up()
		return
	else:
		_state_minigame_intro()
		return

# STATE 4 GAME OVER
func _state_game_over():
	cat_loose.emit()
	current_speed = 1.0
	current_pitch = 1.0
	_apply_speed()
	AudioManager.play("GAMEOVER", current_speed)
	await get_tree().create_timer(2.4).timeout
	get_tree().change_scene_to_packed(results)
	
# STATE 5 SPEED UP
func _state_speed_up():
	cat_speedup.emit()
	AudioManager.play("SPEEDUP", current_speed)
	speedup.emit()
	current_speed = min(current_speed + speed_increment, max_speed)
	current_pitch = min(current_pitch + speed_increment, max_speed)
	_apply_speed()
	await get_tree().create_timer(2.4).timeout
	if _boss_time():
		_state_boss_intro()
	else:
		_state_minigame_intro()

# STATE 6 BOSS INTRO
func _state_boss_intro():
	cat_boss.emit()
	boss_time = true
	minigame_count += 1
	
	AudioManager.play("BOSSTIME", current_speed)
	
	minigame_start.emit()
	in_minigame = true
	
	_emit_intro_data(true)
	await get_tree().create_timer(3.31).timeout
	
	boss_intro.emit()
	transition_start.emit()
	AudioManager.play("MINIBOSS", current_speed)
	UIocult.emit()
	_fade_out_overlay()
	_load_random_boss()
	
func _state_final_victory():
	cat_victory.emit()
	current_speed = 1.0
	current_pitch = 1.0
	_apply_speed()
	#AudioManager.play("GAMEOVER", current_speed)
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_packed(win_screen)
	return
	
#menu de pausa en juego
func toggle_pause():
	if not current_minigame:
		return
	
	paused = !paused
	print("Pause:",paused)
	
	if paused:
		current_minigame.process_mode = Node.PROCESS_MODE_DISABLED
	else:
		current_minigame.process_mode = Node.PROCESS_MODE_INHERIT
	
	pause_changed.emit(paused)
	
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
	if boss_minigames.is_empty():
		return
	var scene: PackedScene = boss_minigames.pick_random()
	_spawn_minigame(scene)

func _spawn_minigame(scene: PackedScene):
	current_minigame = scene.instantiate()
	add_child(current_minigame)
	move_child(current_minigame, 0)

func _speedup() -> bool:
	return (minigame_count % speedup_interval) == 0

func _boss_time() -> bool:
	return (minigame_count % boss_interval) == 0

func _apply_speed():
	Engine.time_scale = current_speed

func _fade_out_overlay():
	return
	
func _fade_in_overlay():
	return
	
func _input(event):
	if event.is_action_pressed("Pause"):
		toggle_pause()
		
func _cleanup_minigame():
	if current_minigame:
		current_minigame.queue_free()
		current_minigame = null

func get_mini_count() -> int:
	return minigame_count
	
func _emit_intro_data(is_boss: bool):
	var scene: PackedScene
	
	if is_boss:
		if boss_minigames.is_empty():
			return
		scene = boss_minigames.pick_random()
	else:
		if current_minigame_index >= shuffled_minigames.size():
			_shuffle_minigames()
		scene = shuffled_minigames[current_minigame_index]
	
	var inst = scene.instantiate()
	var text: String = inst.instr
	var control: int = inst.control_type
	inst.queue_free()
	
	show_intro.emit(text, control)
