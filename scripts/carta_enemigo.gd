extends Carta

class_name CartaEnemigo

# Características
#@export var carta_res: CartaEnemigoRes
var comportamiento: Comportamiento

signal estoy_muerto

func _ready():
	_setear_valores()
	comportamiento = $Efectos.get_children()[0]

func _setear_valores():
	$Frente/Dano.text = str(carta_res.damage)
	$Frente/Vida.text = str(carta_res.max_health)
	$Frente/Dibujo.texture = carta_res.sprite

func ejecutar_turno() -> void:
	comportamiento.avance_fsm()
	pass

func elegir_comportamiento() -> void:
	pass

func restar_vida(cantidad: int):
	$Frente/Vida.text = str(($Frente/Vida.text).to_int() - cantidad)
	esta_muerto()

func esta_muerto() -> bool:
	var estado
	estado = ($Frente/Vida.text.to_int()) <= 0
	if estado:
		estoy_muerto.emit()
		
	return estado
