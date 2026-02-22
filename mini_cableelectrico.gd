extends Node2D
@export var miniGameManager : MiniGameManager
@export var piezas: Array[Node2D]

var rotaciones_correctas = [0,0,0]
var rotaciones = [90,180,270]
var pieza_actual = 0
var piezas_fijadas = []

var juego_terminado = false
func _ready() -> void:
	for i in piezas.size():
		piezas[i].rotation_degrees += rotaciones.pick_random()
		piezas_fijadas.append(false)
	actualizar_contorno()
		
		
func _process(delta: float) -> void:
	if juego_terminado:
		return
	if Input.is_action_just_pressed("Space"):
		rotar_pieza()
		intentar_fijar()
	if Input.is_action_just_pressed("Left"):
		cambiar_pieza(-1)
	if Input.is_action_just_pressed("Right"):
		cambiar_pieza(1)

#rotar pieza seleccionada
func rotar_pieza():
	var idx = pieza_actual
	piezas[idx].rotation_degrees += 90
	if piezas[idx].rotation_degrees >= 360:
		piezas[idx].rotation_degrees = 0
	actualizar_contorno()

#wrap around
func cambiar_pieza(direccion: int):
	# Modulo para moverse circularmente
	pieza_actual = (pieza_actual + direccion + piezas.size()) % piezas.size()
	actualizar_contorno()
	print("Pieza actual:", pieza_actual)
	
func intentar_fijar():
	var x = pieza_actual
	if piezas_fijadas[x]:
		return
	
	#comparar correctamente el angulo 
	var rot_actual = int(piezas[x].rotation_degrees)%360
	var rot_correcta = int(rotaciones_correctas[x])%360
	
	if rot_actual == rot_correcta:
		piezas_fijadas[x] = true
		print("Pieza", x, "fijada correctamente")
	else:
		print("Rotación incorrecta")	
		
		#revisa todas las piezsa
	if todas_piezas_fijas():
		juego_terminado=true	
		miniGameManager.changeWin(true)
		print("Win ;")
	
		
func todas_piezas_fijas() -> bool:
	for f in piezas_fijadas:
		if not f:
			return false
	return true
	
func actualizar_contorno():
	for i in piezas.size():
		var rot_actual = int(round(piezas[i].rotation_degrees)) % 360
		var rot_correcta = int(rotaciones_correctas[i]) % 360
		
		if piezas_fijadas[i] and rot_actual !=rot_correcta:
			piezas_fijadas[i] = false	
		
		   
	
