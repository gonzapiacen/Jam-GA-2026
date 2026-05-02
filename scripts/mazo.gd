extends Node2D
class_name Mazo

var cartas : Array[Carta2D] = []

#func _ready() -> void:

func push_back(carta: Carta2D):
	cartas.push_back(carta)

func robar_carta() -> Carta2D:
	return cartas.pop_back()

func shuffle():
	cartas.shuffle()

func clear():
	cartas.clear()
	

#@export var cantidad_de_cartas: int = 20
#
#
#var cartas_scenes = {
#	ALFAJOR = preload("res://scenes/cartas/alfajor.tscn"),
#	}
#
#var cartas: Array[Carta] = []
#
#signal cambio_cantidad_cartas
#
## Called when the node enters the scene tree for the first time.
#func inicializar() -> void:
#	for i in range (cantidad_de_cartas):
#		cartas.push_back(cartas_scenes["ALFAJOR"])
#
#	cartas.shuffle()
#	
##func _crear_carta() -> Carta:
##	#TODO cambiar por cargar cartas de recursos
##	var nueva_carta
##	nueva_carta = Carta.new()
##	nueva_carta.energia = randi() % 9
##	nueva_carta.es_consumible = randi() % 2
##	nueva_carta.durabilidad = ((randi() % 9) + 1)
##	
##	return nueva_carta
#
#func robar_carta() -> Carta:
#	if cartas.is_empty():
#		return null
#	var carta = cartas.pop_back()
#	emit_signal("cambio_cantidad_cartas")
#	return carta
#
#func anadir_carta(nueva_carta: Carta) -> void:
#	cartas.push_back(nueva_carta)
#	cartas.shuffle()
#
#"""
#ESTO PRECARGA EL RECURSO CARTA SIN NECESIDAD DE HACERLO POR CODIGO (SOLO PARA REPETICIONES)
#mazo.append(preload("res://cartas/carta_hielo.tres"))
#"""
