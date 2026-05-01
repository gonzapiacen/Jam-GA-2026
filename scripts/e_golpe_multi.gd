extends Efecto
class_name GolpeMultiple

@export var puntos : int = 3

func serializar() -> String:
	return "Hace " + str(puntos) + " puntos de daño a todos los enemigos"

func activar():
	super()
	# TODO conseguir todos los enemigos y hacerles daño equivalente a los puntos
