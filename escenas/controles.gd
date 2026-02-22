extends Label

func _ready():
	GameManager.show_intro.connect(_on_show_intro)
	visible = false
	GameManager.UIocult.connect(_on_ui_ocult)
	GameManager.minigame_end.connect(_on_minigame_end)

func _on_ui_ocult():
	modulate.a = 0

func _on_minigame_end():
	modulate.a = 1

func _on_show_intro(text: String, _control_type: int):
	visible = false
	self.text = text
	await get_tree().create_timer(1.0).timeout
	visible = true
