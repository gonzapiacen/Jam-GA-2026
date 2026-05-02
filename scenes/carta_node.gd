extends Node2D

class_name Carta2D

var carta: Carta

var seleccionada: bool = false

signal enviar_al_campo(carta)

func set_carta(c: Carta) -> void:
	carta = c
	_set_vista()
	
func _set_vista() -> void:
	$Frente/Energia/ValorEnergia.text = str(carta.energia)
	$Frente/Efecto/ValorEfecto.text = str(carta.efecto)
	$Frente/Durabilidad/ValorDurabilidad.text = str(carta.durabilidad)

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		enviar_al_campo.emit(self)
