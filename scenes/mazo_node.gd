extends Node2D

class_name Mazo2D

var mazo: Mazo

func inicializar() -> Mazo:
	mazo = Mazo.new()
	mazo.inicializar()
	$Cartas.text = str(mazo.cartas.size())
	mazo.cambio_cantidad_cartas.connect(actualizar_cantidad)
	
	return mazo

func actualizar_cantidad():
	$Cartas.text = str(mazo.cartas.size())
