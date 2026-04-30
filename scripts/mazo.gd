extends Resource

class_name Mazo

@export var cantidad_de_cartas: int = 20

var cartas: Array[Carta] = []

# Called when the node enters the scene tree for the first time.
func inicializar() -> void:
	for i in range (cantidad_de_cartas):
		cartas.push_back(_crear_carta())

	cartas.shuffle()
	
func _crear_carta() -> Carta:
	var nueva_carta
	nueva_carta = Carta.new()
	nueva_carta.energia = randi() % 9
	nueva_carta.efecto = ((randi() % 9) + 1)
	nueva_carta.tipo_de_efecto = randi() % 3
	nueva_carta.es_consumible = randi() % 2
	nueva_carta.durabilidad = ((randi() % 9) + 1)
	
	return nueva_carta

func robar_carta() -> Carta:
	if cartas.is_empty():
		return null
	
	return cartas.pop_back()

func anadir_carta(nueva_carta: Carta) -> void:
	cartas.push_back(nueva_carta)
	cartas.shuffle()

"""
ESTO PRECARGA EL RECURSO CARTA SIN NECESIDAD DE HACERLO POR CODIGO (SOLO PARA REPETICIONES)
mazo.append(preload("res://cartas/carta_hielo.tres"))
"""
