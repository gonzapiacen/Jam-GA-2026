extends Node
class_name AtaqueManager

static func atacar_jugador(valor: int):
	if Globales.jugador.tiene_defensa():
		Globales.jugador.restar_defensa(valor)
	else:
		Globales.jugador.restar_vida(valor)	

static func atacar_enemigo(valor: int, posicion_enemigo: int):
	Globales.enemigo.restar_vida(valor)
