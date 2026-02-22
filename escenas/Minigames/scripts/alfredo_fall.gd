extends Node2D

@export var max_angle = 65.0
@export var tilt_speed = 120.0    
@export var fall_accel = 40.0 
@export var minigame_manager:MiniGameManager

var current_angle = 0.0
var direction = 0.0
var falling = false

func _ready():
	current_angle = randf_range(-5.0, 5.0)
	_check_dir()
	rotation_degrees = current_angle

func _process(delta):
	if falling:
		position.y += 40
		return

	_check_dir()
	current_angle += direction * fall_accel * delta

	# control jugador
	if Input.is_key_pressed(KEY_A):
		current_angle -= tilt_speed * delta
	if Input.is_key_pressed(KEY_D):
		current_angle += tilt_speed * delta

	rotation_degrees = current_angle

	if abs(current_angle) >= max_angle:
		falling = true
		minigame_manager.changeWin(false)
		return

func  _check_dir():
	if (current_angle > 0):
		direction = 1.0
	else:
		direction = -1.0
		
		
		
		
