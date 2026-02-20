extends Node

@export var minigames: Array[PackedScene]
@export var boss_minigames: Array[PackedScene]

@export var endless: bool = false
@export var boss_interval: int = 15
@export var speedup_interval: int = 6

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

# SEÑALES
signal comence
signal minigame_start
signal win
signal lost
signal speedup
signal boss_intro

# ESTADO 0 START

func _state_start():
	_shuffle_minigames()
	lives = 4
	minigame_count = 0
	current_speed = 1.0
	current_pitch = 1.0
	
	AudioManager.play("GANAR")
	
	comence.emit()
	
	await get_tree().create_timer(2.4).timeout
	
	_state_minigame_intro()

# ESTADO 1 COMIENZA MINIJUEGO

func _state_minigame_intro():
	boss_time = false
	
	AudioManager.play("NEXT")
	
	
	
	
	#que se muestre el control a usar en una imagen
	
	await get_tree().create_timer(2).timeout
	
	_fade_out_overlay()
	_load_next_minigame()
	
	minigame_start.emit()
	#texto que indica lo que hacer
	#voz dice lo que hacer

# ESTADO 2 - VICTORIA

func _state_win():
	AudioManager.play("GANAR")
	win.emit()
	minigame_count += 1
	_cleanup_minigame()
	
	await get_tree().create_timer(2.4).timeout
	
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

# ESTADO 3 PERDER

func _state_lose():
	lives -= 1
	lost.emit()
	AudioManager.play("PERDIDO")
	_cleanup_minigame()
	
	await get_tree().create_timer(2.4).timeout
	
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

# ESTADO 4 GAME OVER

func _state_game_over():
	current_speed = 1.0
	current_pitch = 1.0
	_apply_speed()
	AudioManager.play("GAMEOVER")
	await get_tree().create_timer(2.4).timeout
	#ir a pantalla de game over

# ESTADO 5 SPEED UP

func _state_speed_up():
	AudioManager.play("SPEEDUP")
	speedup.emit()
	
	#para que no se pase de velocidad
	current_speed = min(current_speed + speed_increment, max_speed)
	current_pitch = min(current_pitch + speed_increment, max_speed)
	_apply_speed()
	
	await get_tree().create_timer(2.4).timeout
	
	if _boss_time():
		_state_boss_intro()
		return
	else:
		_state_minigame_intro()
		return

# ESTADO 6 BOSS INTRO

func _state_boss_intro():
	boss_time = true
	AudioManager.play("BOSSTIME")
	_load_random_boss()
	await get_tree().create_timer(2.4).timeout
	
	boss_intro.emit()
	#mostrar imagnees del control que toca
	#transiciones hasta nivel de boss blabla
	#texto que indica lo que hacer
	#voz dice lo que hacer

# ESTADO 7 VICTORIA FINAL

func _state_final_victory():
	#JIngle de victoria final
	# animaciones y cosas, ya sew planificara
	return
	
# METODOS AUXILIARES

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
	if current_minigame:
		current_minigame.queue_free()
	
	current_minigame = scene.instantiate()
	add_child(current_minigame)
	move_child(current_minigame, 0)

func _speedup() -> bool:
	# HACER
	return false

func _boss_time() -> bool:
	# HACER
	return false

func _apply_speed():
	Engine.time_scale = current_speed
	#cambiar el pitch global de sonido

func _fade_out_overlay():
	return
	
func _fade_in_overlay():
	return
	
func _cleanup_minigame():
	if current_minigame:
		current_minigame.queue_free()
		current_minigame = null
