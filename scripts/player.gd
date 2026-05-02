extends Node
class_name Player

@export var health: int
@export var energy: int

var mazo: Mazo
var mano: Array[Carta] = []
var descarte: Array[Carta] = []
var campo: Array[Carta] = [null, null, null]

func tiene_campo_lleno() -> bool:
	return (campo[0] && campo[1] && campo[2])

func modified_health(i: int):
	health = health + i

func modified_energy(i: int):
	energy = energy + i

func descartar_mano():
	for carta in mano:
		descarte.push_back(mano.pop_back())
		
func descartar_carta(c: Carta):
	mano.erase(c)
	descarte.push_back(c)
	
func robar_carta() -> Carta:
	var temp = mazo.robar_carta()
	mano.append(temp)
	
	return temp

func colocar_descarte_en_mazo():
	for carta in descarte:
		mazo.anadir_carta(carta)

func jugar_carta_campo(c: Carta, pos: int):
	mano.erase(c)
	campo[pos] = c

func am_i_death() -> bool:
	return health <= 0
