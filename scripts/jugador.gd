extends Node
class_name Jugador

var _vida := 10
var _max_vida := 10
var _ap := 3
var _defensa := 0
#var vida := 10
#	set(val):
#		if val < _vida:
#			restar_vida(val)
#		else:
#			sumar_vida(val)
#	get(): return _vida


signal vida_cambio
signal ap_cambio
signal defensa_cambio
signal vida_up
signal vida_down
signal muerto
signal ap_up
signal ap_down
signal defensa_up
signal defensa_down

func tiene_defensa() -> bool:
	return _defensa > 0

func get_vida() -> int:
	return _vida

func get_ap() -> int:
	return _ap

func get_defensa():
	return _defensa

## Resta la cantidad cant a la vida actual del jugador
func restar_vida(cant: int):
	_vida -= cant
	vida_cambio.emit()
	vida_down.emit()
	if _vida <= 0:
		muerto.emit()

## Suma la cantidad cant a la vida actual del jugador
## La vida solo puede subir hasta max_vida
func sumar_vida(cant: int):
	_vida += cant
	_vida = min(_vida, _max_vida)
	vida_cambio.emit()
	vida_up.emit()

## Suma la cantidad cant a la defensa actual del jugador
func sumar_defensa(cant: int):
	_defensa += cant
	defensa_cambio.emit()
	defensa_up.emit()
	
## Suma la cantidad cant a la defensa actual del jugador
func restar_defensa(cant: int):
	_defensa -= cant
	# la defensa no puede bajar de 0
	_defensa = max(_defensa, 0)
	defensa_cambio.emit()
	defensa_down.emit()

## Resta la cantidad cant de los puntos de accion del jugador
## retorna true si fue exitosa. falso si no fue exitosa
func usar_ap(cant: int) -> bool:
	if cant > _ap:
		return false
	_ap -= cant
	ap_cambio.emit()
	ap_down.emit()
	return true
	
## Suma la cantidad cant a los puntos de accion del jugador
func sumar_ap(cant: int):
	_ap += cant
	ap_cambio.emit()
	ap_up.emit()
