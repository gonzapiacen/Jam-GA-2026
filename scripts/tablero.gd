extends Node2D
class_name Tablero

#@onready var mazo_jugador: Mazo = $MazoJugador
#@onready var mazo_enemigo: Mazo = $MazoEnemigo
@export var mazo_jugador: Mazo
@export var mazo_enemigo: Mazo

var mano: Array[Carta2D] = []
var descarte: Mazo

# ESCENAS
const ESCENA_LOBO = preload("res://scenes/cartas/lobo.tscn")
const ESCENA_ALFAJOR = preload("res://scenes/cartas/alfajor.tscn")
const ESCENA_MEDIALUNA = preload("res://scenes/cartas/medialuna.tscn")
const ESCENA_FACON = preload("res://scenes/cartas/facon.tscn")
const ESCENA_PALO = preload("res://scenes/cartas/palo.tscn")


var campo_enemigo: Array[Carta2D] = [null, null, null]
var campo_jugador: Array[Carta2D] = [null, null, null]

func _ready():
	
	var carta_creada
	for i in range(2):
		carta_creada = ESCENA_FACON.instantiate()
		mazo_jugador.add_child(carta_creada)
		mazo_jugador.push_back(carta_creada)
	
	for i in range(2):
		carta_creada = ESCENA_ALFAJOR.instantiate()
		mazo_jugador.add_child(carta_creada)
		mazo_jugador.push_back(carta_creada)
		
	for i in range(2):
		carta_creada = ESCENA_MEDIALUNA.instantiate()
		mazo_jugador.add_child(carta_creada)
		mazo_jugador.push_back(carta_creada)
		
	mazo_jugador.shuffle()

func campo_jugador_lleno() -> bool:
	return (campo_jugador[0] && campo_jugador[1] && campo_jugador[2])

func campo_enemigo_lleno() -> bool:
	return (campo_enemigo[0] && campo_enemigo[1] && campo_enemigo[2])

func descartar_mano():
	for carta in mano:
		descarte.poner_en_tope(mano.pop_back())
		
func descartar_carta(carta: Carta2D):
	mano.erase(carta)
	descarte.push_back(carta)
	
func robar_carta() -> Carta:
	var temp = mazo_jugador.robar_carta()
	mano.append(temp)
	return temp

func colocar_descarte_en_mazo():
	mazo_jugador.cartas.append_array(descarte.cartas)
	mazo_jugador.shuffle()
	descarte.clear() 

func jugar_carta_campo(c: Carta2D, pos: int):
	mano.erase(c)
	campo_jugador[pos] = c
