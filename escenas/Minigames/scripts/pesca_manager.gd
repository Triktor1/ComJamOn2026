extends Node2D

@export var sprites:Array[Texture2D]
@export var minigame_manager:MiniGameManager
@export var start_wait_time:float=2.0
@export var time_to_change:float=1.0
@export var max_score_to_reach:float=200.0
@export var key:Sprite2D
@export var fishes:Node


@export var speed:float=2.0

var can_start:bool=false
var time:float=0

var directions:Array=["W","A","S","D"]
var current_direction:String=""

var score:float=2.0
var evil_score:float=0.0

var is_pressed:bool=false

func _ready() -> void:
	_randomize_direction()
	await get_tree().create_timer(start_wait_time).timeout
	can_start=true
	key.visible=true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if can_start:
		if (current_direction == "W" and Input.is_action_pressed("Up")) \
		or (current_direction == "A" and Input.is_action_pressed("Left")) \
		or (current_direction == "S" and Input.is_action_pressed("Down")) \
		or (current_direction == "D" and Input.is_action_pressed("Right")):
			is_pressed = true
		else:
			is_pressed = false
		time+=delta
		if time>=time_to_change:
			_randomize_direction()
			time=0
		if is_pressed:
			score+=delta
			if score>=max_score_to_reach and evil_score<score:
				_catch_fish()
		evil_score+=delta
		if evil_score>=score:
			minigame_manager.changeWin(false)
		
		if current_direction=="W":
			key.global_position.y+=speed*delta
		elif current_direction=="A": 
			key.global_position.x+=speed*delta
		elif current_direction=="S":
			key.global_position.y-=speed*delta
		elif current_direction=="D":
			key.global_position.x-=speed*delta

func _randomize_direction():
	current_direction=directions.pick_random()
	if current_direction=="W":
		key.texture=sprites[0]
	elif current_direction=="A":
		key.texture=sprites[1]
	elif current_direction=="S":
		key.texture=sprites[2]
	elif current_direction=="D":
		key.texture=sprites[3]


func _catch_fish():
	var caught_fish:Sprite2D=fishes.get_children().pick_random()
	caught_fish.visible=true
	minigame_manager.changeWin(true)
