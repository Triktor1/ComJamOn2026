extends Node2D

@export var instr: String = ""

enum ControlType {
	WASD,
	ZX,
	SPACE,
	ADS,
	HOLD
}

@export var control_type: ControlType = ControlType.WASD


func _ready():
	pass


func _process(delta):
	pass
