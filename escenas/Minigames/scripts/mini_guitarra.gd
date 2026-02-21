extends Node2D

@export var key1:Label
@export var key2:Label
@export var key3:Label
@export var key4:Label
@export var minigame_manager:MiniGameManager

var keys:Array=[]
var keys_to_press:Array=[]
var current_key=0

var heights:Array=[-174,-37,37,174]

var done:bool=false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	keys=[key1,key2,key3,key4]
	keys_to_press.push_back(randi_range(1,4))
	keys_to_press.push_back(randi_range(1,4))
	keys_to_press.push_back(randi_range(1,4))
	keys_to_press.push_back(randi_range(1,4))
	
	
	assign_key(keys_to_press[0],key1)
	assign_key(keys_to_press[1],key2)
	assign_key(keys_to_press[2],key3)
	assign_key(keys_to_press[3],key4)

func assign_key(number:int,label:Label):
	if number==1:
		label.text="W"
	elif number==2:
		label.text="A"
	elif number==3:
		label.text="S"
	elif number==4:
		label.text="D"
	label.global_position.y=heights[number-1]

func _input(event: InputEvent) -> void:
	if not done:
		if event is InputEventKey and event.pressed and not event.echo:
			if event.is_action_pressed("Up") and keys_to_press[current_key]==1:
				keys[current_key].text=""
				current_key+=1
			elif event.is_action_pressed("Left") and keys_to_press[current_key]==2:
				keys[current_key].text=""
				current_key+=1
			elif event.is_action_pressed("Down") and keys_to_press[current_key]==3:
				keys[current_key].text=""
				current_key+=1
			elif event.is_action_pressed("Right") and keys_to_press[current_key]==4:
				keys[current_key].text=""
				current_key+=1
			else:
				print("lose :(") #perder automaticamente
				minigame_manager.changeWin(false)
				done=true
			if current_key==4:
				print("win :)") #win automatico
				minigame_manager.changeWin(true)
				done=true
