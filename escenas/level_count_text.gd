extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.minigame_start.connect(_ask_mini_count)

func _ask_mini_count():
	text = str(GameManager.get_mini_count())
