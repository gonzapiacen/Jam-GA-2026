extends Node2D

class_name Mazo

var cartas : Array[Carta] = []

signal robo_carta
signal agregado_carta
signal sin_cartas

func agregar_carta(carta: Carta):
	cartas.push_back(carta)
	mezclar()
	agregado_carta.emit()

func robar_carta() -> Carta:
	var carta_robada = cartas.pop_back()
	robo_carta.emit(carta_robada)
	if(mazo_vacio()):
		sin_cartas.emit()
	return carta_robada

func mezclar():
	cartas.shuffle()

func vaciar():
	cartas.clear()

func mazo_vacio() -> bool:
	return cartas.size() == 0
