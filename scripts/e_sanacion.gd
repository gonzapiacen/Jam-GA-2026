extends Efecto
class_name Sanacion

@export var puntos : int = 3

func serializar() -> String:
	return "Sana " + str(puntos) + " puntos de vida"

func activar():
	super()
	Globales.jugador.sumar_vida(puntos)
