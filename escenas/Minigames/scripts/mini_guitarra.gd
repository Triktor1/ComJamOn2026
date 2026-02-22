extends Node2D

@export var key1:Sprite2D
@export var key2:Sprite2D
@export var key3:Sprite2D
@export var key4:Sprite2D
@export var minigame_manager:MiniGameManager

@export var sprites:Array[Texture2D]

@export var bajo:Sprite2D
@export var won:Sprite2D
@export var lost:Sprite2D

var sprites_left:Array=[]
var keys_to_press:Array=[]
var current_key=0

var heights:Array=[-174,-37,37,174]

var done:bool=false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprites_left=[key1,key2,key3,key4]
	keys_to_press.push_back(randi_range(1,4))
	keys_to_press.push_back(randi_range(1,4))
	keys_to_press.push_back(randi_range(1,4))
	keys_to_press.push_back(randi_range(1,4))
	
	
	assign_key(keys_to_press[0],key1)
	assign_key(keys_to_press[1],key2)
	assign_key(keys_to_press[2],key3)
	assign_key(keys_to_press[3],key4)

func assign_key(number:int,sprite:Sprite2D):
	if number==1:
		sprite.texture=sprites[0]
	elif number==2:
		sprite.texture=sprites[1]
	elif number==3:
		sprite.texture=sprites[2]
	elif number==4:
		sprite.texture=sprites[3]
	sprite.global_position.y=heights[number-1]

func _input(event: InputEvent) -> void:
	if not done:
		if event is InputEventKey and event.pressed and not event.echo:
			if event.is_action_pressed("Up") and keys_to_press[current_key]==1:
				sprites_left[current_key].texture=null
				current_key+=1
			elif event.is_action_pressed("Left") and keys_to_press[current_key]==2:
				sprites_left[current_key].texture=null
				current_key+=1
			elif event.is_action_pressed("Down") and keys_to_press[current_key]==3:
				sprites_left[current_key].texture=null
				current_key+=1
			elif event.is_action_pressed("Right") and keys_to_press[current_key]==4:
				sprites_left[current_key].texture=null
				current_key+=1
			else:
				lost.visible=true
				bajo.visible=false
				minigame_manager.changeWin(false)
				done=true
			if current_key==4:
				won.visible=true
				bajo.visible=false
				minigame_manager.changeWin(true)
				done=true
