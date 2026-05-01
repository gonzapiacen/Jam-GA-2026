extends Node2D

var mazo: Mazo

func inicializar() -> Mazo:
	mazo = Mazo.new()
	mazo.inicializar()
	$Cartas.text = str(mazo.cartas.size())
	
	return mazo

func robar_carta() -> Carta:
	var carta = mazo.robar_carta()
	$Cartas.text = str(mazo.cartas.size())
	
	return carta
