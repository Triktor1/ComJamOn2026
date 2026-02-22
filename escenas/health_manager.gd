extends Node2D

@export var heart_scene: PackedScene
@export var ovillo: PackedScene
@export var start_lives: int = 4

var hearts: Array[Node2D] = []
var current_lives: int = 0

func _ready():
	start_lives = GameManager.lives
	
	GameManager.lost.connect(_on_player_lost)
	GameManager.comence.connect(_on_game_start)
	GameManager.UIocult.connect(_on_ui_ocult)
	GameManager.minigame_end.connect(_on_minigame_end)

func _on_game_start():
	_initialize_hearts(start_lives)

func _initialize_hearts(lives: int):
	_clear_hearts()
	current_lives = lives
	
	for i in range(lives):
		var heart = heart_scene.instantiate()
		add_child(heart)
		
		var anim_sprite = heart.get_node("AnimatedSprite2D")
		heart.position.x = i * anim_sprite.sprite_frames.get_frame_texture("heart_idle", 0).get_width()
		
		anim_sprite.play("heart_idle")
		hearts.append(heart)

func _on_player_lost():
	if current_lives <= 0:
		return
	
	current_lives -= 1
	
	var heart = hearts[current_lives]
	var anim = heart.get_node("AnimatedSprite2D")
	anim.play("heart_death")
	
	await anim.animation_finished
	heart.modulate.a = 0.3 # se hace parcialmente transparente

func _on_ui_ocult():
	modulate.a = 0

func _on_minigame_end():
	modulate.a = 1

func _clear_hearts():
	for h in hearts:
		if is_instance_valid(h):
			h.queue_free()
	hearts.clear()
