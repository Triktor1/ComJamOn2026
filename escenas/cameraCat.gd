extends CanvasLayer

func _ready():
	GameManager.UIocult.connect(_on_ui_ocult)
	GameManager.minigame_end.connect(_on_minigame_end)

func _on_ui_ocult():
	visible = false

func _on_minigame_end():
	visible = true
