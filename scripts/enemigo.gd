extends Node2D

class_name Enemigo

@export var textura: Texture2D
@export var nombre: String
@export var descripcion: String
@export var max_health: int
@export var health: int
@export var damage: int
@export var defense: int

var comportamiento: Comportamiento

func ejecutar_turno() -> void:
	comportamiento.avance_fsm()
	pass

func elegir_comportamiento() -> void:
	pass
	
func restar_vida(cantidad: int):
	health -= cantidad

func esta_muerto() -> bool:
	return health <= 0
