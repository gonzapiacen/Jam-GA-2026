@abstract
extends Node
class_name Efecto

signal activado(Efecto)

@abstract func serializar() -> String

func activar():
	activado.emit(self)
	pass
