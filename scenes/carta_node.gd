extends Node2D

var carta: Carta

# Called every frame. 'delta' is the elapsed time since the previous frame.
func set_carta(c: Carta) -> void:
	carta = c
	set_vista()
	
func set_vista() -> void:
	$Frente/Energia/ValorEnergia.text = str(carta.energia)
	$Frente/Efecto/ValorEfecto.text = str(carta.efecto)
	$Frente/Durabilidad/ValorDurabilidad.text = str(carta.durabilidad)
