extends Efecto
class_name Fortificar

@export var puntos : int = 3

func serializar() -> String:
	return "Suma " + str(puntos) + " puntos de defensa al jugador"

func activar():
	super()
	Globales.jugador.sumar_defensa(puntos)
