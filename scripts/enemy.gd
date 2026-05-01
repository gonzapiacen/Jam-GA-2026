extends Node
class_name Enemy

@export var textura: Texture2D
@export var nombre: String
@export var descripcion: String
@export var health: int
@export var damage: int
@export var defense: int
@export var player: Jugador
var comportamiento: Comportamiento

func ejecutar_turno() -> void:
	pass

func elegir_comportamiento() -> void:
	pass
