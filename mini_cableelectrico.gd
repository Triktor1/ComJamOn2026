extends Node2D
@export var miniGameManager : MiniGameManager
@export var piezas: Array[Node2D]

var rotaciones_correctas = [0,0,0]
var pieza_actual = 0
var piezas_fijadas = []

func _ready() -> void:
	for i in piezas.size():
		piezas_fijadas.append(false)
		
		
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Extra1"):
		rotar_pieza()
	if Input.is_action_just_pressed("Extra2"):
		intentar_fijar()
	
func rotar_pieza():
	if piezas_fijadas[pieza_actual]:
		return
	piezas[pieza_actual].rotation_degrees += 90
	
	if piezas[pieza_actual].rotation_degrees >= 360:
		piezas[pieza_actual].rotation_degrees = 0
		
func intentar_fijar():
	# Si ya está fijada no hacemos nada
	if piezas_fijadas[pieza_actual]:
		return
	
	var rot_actual = int(piezas[pieza_actual].rotation_degrees)
	var rot_correcta = rotaciones_correctas[pieza_actual]
	
	if rot_actual == rot_correcta:
		piezas_fijadas[pieza_actual] = true
		print("Pieza", pieza_actual, "fijada correctamente")
		
		pieza_actual += 1
		
		if pieza_actual >= piezas.size():
			miniGameManager.changeWin(true)
			print("Win ;")
	else:
		print("Rotación incorrecta")
