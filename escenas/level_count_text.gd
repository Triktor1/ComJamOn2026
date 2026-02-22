extends Label

func _ready():
	GameManager.minigame_start.connect(_ask_mini_count)
	GameManager.UIocult.connect(_on_ui_ocult)
	GameManager.minigame_end.connect(_on_minigame_end)

func _on_ui_ocult():
	modulate.a = 0

func _on_minigame_end():
	modulate.a = 1

func _ask_mini_count():
	text = str(GameManager.get_mini_count())
	modulate.a = 1
