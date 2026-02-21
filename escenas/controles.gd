extends Label

func _ready():
	GameManager.show_intro.connect(_on_show_intro)
	visible = false

func _on_show_intro(text: String, _control_type: int):
	visible = false
	self.text = text
	await get_tree().create_timer(1.0).timeout
	visible = true
