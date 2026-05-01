extends Node
class_name AtaqueManager

static func atacar_jugador(valor: int):
	if Globales.jugador.tiene_defensa():
		Globales.jugador.restar_defensa(valor)
	else:
		Globales.jugador.restar_vida(valor)	

