extends Efecto
class_name GolpeSimple

@export var puntos : int = 3

func serializar() -> String:
	return "Hace " + str(puntos) + " puntos de daño a un enemigo objetivo"

func activar():
	super()
	# TODO de alguna manera esperar a que el controlador seleccione un elemento
