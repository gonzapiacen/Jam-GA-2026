extends Node
class_name Player

@export var health: int
@export var energy: int

var mazo: Mazo
var mano: Array[Carta] = []
var descarte: Array[Carta] = []
var campo: Array[Carta] = []

func modified_health(i: int) -> void:
	health = health + i

func modified_energy(i: int) -> void:
	energy = energy + i

func descartar_mano() -> void:
	for carta in mano:
		descarte.push_back(mano.pop_back())

func colocar_descarte_en_mazo() -> void:
	for carta in descarte:
		mazo.anadir_carta(carta)
