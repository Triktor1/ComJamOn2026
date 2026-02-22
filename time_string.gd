extends Node2D

@export var minigame_manager: MiniGameManager
@export var animated_sprite: AnimatedSprite2D

func _ready():
	minigame_manager.countdown_start.connect(_on_first)
	minigame_manager.countdown_second.connect(_on_second)
	minigame_manager.countdown_final.connect(_on_final)

func _on_first():
	animated_sprite.play("Timer3")

func _on_second():
	animated_sprite.play("Timer2")

func _on_final():
	animated_sprite.play("Timer1")
