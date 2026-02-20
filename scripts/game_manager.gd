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


# ESTADO 0 START

func _state_start():
	_shuffle_minigames()
	lives = 4
	minigame_count = 0
	current_speed = 1.0
	current_pitch = 1.0
	
	AudioManager.play("GANAR")
	
	# animaciones de comienzo, emitiendo señal o no se
	
	await get_tree().create_timer(2.4).timeout
	
	_state_minigame_intro()

# ESTADO 1 COMIENZA MINIJUEGO

func _state_minigame_intro():
	boss_time = false
	
	AudioManager.play("NEXT")
	
	_load_next_minigame()
	
	#que se muestre el control a usar en una imagen
	
	await get_tree().create_timer(1).timeout
	
	#señal de animacion de transicion
	
	#texto que indica lo que hacer
	#voz dice lo que hacer

# =========================
# ESTADO 2 - VICTORIA
# =========================

func _state_win():
	#jingle de victoria
	#comienza la animacion de que vuelve la transicion y se quita el minijuego anterior al terminar
	minigame_count += 1
	
	if boss_time:
		if not endless:
			#esperar a fin de jingle
			#cambiar a estado de boss
			return
		else:
			lives += 1
	
	#se espera a fin de jingle
	
	if _speedup():
		#cambiar al estado speed up
		return
	elif _boss_time():
		#cambiar a estado de boss
		return
	else:
		#cambiar a estado minigame intro
		return

# ESTADO 3 PERDER

func _state_lose():
	lives -= 1
	#animacion de derrota de la escena y tal
	#Jingle de derrota
	
	#se espera a fin de jingle
	
	if lives <= 0:
		#cambiar a estado de game over
		return
	
	if boss_time:
		if endless:
			boss_time = false
			#cambiar a estado minigame intro
		else:
			#cambiar a estado de boss
			return
		return
	
	if _speedup():
		#cambiar a estado de speed up
		return
	else:
		#cambiar a estado de minigame intro
		return

# ESTADO 4 GAME OVER

func _state_game_over():
	current_speed = 1.0
	current_pitch = 1.0
	_apply_speed()
	#jingle de game over
	#esperar a que acabe jingle de game over
	#ir a pantalla de game over

# ESTADO 5 SPEED UP

func _state_speed_up():
	#jingle de speed up
	#tweens de speed up y animaciones
	
	#para que no se pase de velocidad
	current_speed = min(current_speed + speed_increment, max_speed)
	current_pitch = min(current_pitch + speed_increment, max_speed)
	_apply_speed()
	
	#se espera a fin de jingle de speed up
	
	if _boss_time():
		#cambiar a estado de boss
		return
	else:
		#cambiar a estado minigame intro
		return

# ESTADO 6 BOSS INTRO

func _state_boss_intro():
	boss_time = true
	#jingle de boss
	_load_random_boss()
	#esperar a fin de jingle 
	
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
	return

func _load_next_minigame():
	return

func _load_random_boss():
	return

func _spawn_minigame(scene: PackedScene):
	return

func _on_minigame_won():
	# ESTE METODO LO LLAMARAN LOS MINIJUEGOS PARA CAMBIAR AL ESTADO DE VICTORIA
	return

func _on_minigame_lost():
	# ESTE METODO LO LLAMARAN LOS MINIJUEGOS PARA CAMBIAR AL ESTADO DE DERROTA
	return 

func _speedup() -> bool:
	# HACER
	return false

func _boss_time() -> bool:
	# HACER
	return false

func _apply_speed():
	Engine.time_scale = current_speed
	#cambiar el pitch global de sonido
