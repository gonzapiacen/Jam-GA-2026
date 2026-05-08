extends Efecto
class_name GolpeSimple

var puntos : int = 3

func serializar() -> String:
	return "Hace " + str(puntos) + " puntos de daño a un enemigo objetivo"

func activar():
	super()
	Globales.enemigos[0].restar_vida(get_parent().get_parent().carta_res.cantidad)
	# TODO de alguna manera esperar a que el controlador seleccione un elemento
