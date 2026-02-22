extends Control

@export var wasd_textures: Array[Texture2D]
@export var zx_textures: Array[Texture2D]
@export var space_textures: Array[Texture2D]
@export var ads_textures: Array[Texture2D]

func _ready():
	GameManager.show_intro.connect(_on_show_intro)
	GameManager.UIocult.connect(_on_ui_ocult)
	GameManager.minigame_end.connect(_on_minigame_end)

func _on_ui_ocult():
	modulate.a = 0

func _on_minigame_end():
	modulate.a = 1

func _on_show_intro(_text: String, control_type: int):
	for child in get_children():
		child.queue_free()
	
	var textures: Array[Texture2D]
	
	match control_type:
		GameManager.ControlType.WASD:
			textures = wasd_textures
		GameManager.ControlType.ZX:
			textures = zx_textures
		GameManager.ControlType.SPACE:
			textures = space_textures
		GameManager.ControlType.ADS:
			textures = ads_textures
	
	for texture in textures:
		var sprite := Sprite2D.new()
		sprite.texture = texture
		add_child(sprite)
