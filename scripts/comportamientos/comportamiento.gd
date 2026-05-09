@abstract
extends Node
class_name Comportamiento

#var monstruo : Enemigo
var monstruo : CartaEnemigo

func _ready():
	monstruo = get_parent().get_parent()

@abstract func ejecutar_estado() -> void

@abstract func avance_fsm() -> void
