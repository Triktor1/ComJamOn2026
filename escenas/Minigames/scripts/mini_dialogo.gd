extends Node2D

@onready var dialogue_lines=[
	"Créeme, no es la primera vez que algo así sucede.",
	"Es adorable que creas que puedo hacer lo que me dé la gana.",
	"Un inconveniente que me está dificultando el trabajo.",
	"No puedo seguir atascado en el caso de una única alma.",
	"Para haberlo sabido ya, te ha costado un rato darte cuenta.",
	"Te dije que quería hablar contigo hace semanas.",
	"No sé qué haría si no estuvieses en mi vida.",
	"Tú eres quien me enterró aquí.",
	"¿Me está pidiendo que me calle?",
	"Necesito que me escuches.",
	"Llevo queriendo hablar contigo toda la semana.",
	"Es un lugar bonito. Y tranquilo.",
	"Me gustaría que dejaras de bromear durante un segundo.",
	"Hemos tenido un montón de discusiones por esto mismo.",
	"Lo importante es que me prometiste que ibas a venir.",
	"Estoy aceptando tu plan. ¿No estás conforme?",
	"Primero me haces esperar y luego te olvidas de lo que hablamos."
]

@export var minigame_manager:MiniGameManager

@export var dialogue_label:Label
@export var skips_to_win:int=10

var skips:int=0

func _ready() -> void:
	_change_dialogue()

func _change_dialogue():
	dialogue_label.text=dialogue_lines.pick_random()
	skips+=1
	
	if skips>=skips_to_win:
		minigame_manager.changeWin(true)
		print("won")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Space"):
		_change_dialogue()
