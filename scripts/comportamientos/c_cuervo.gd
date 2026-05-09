extends Comportamiento
class_name CompCuervo

enum Estado {
	Neutral,
	Volar,
	PreAtkVolar,
	PrePicotazo,
	}

@export var chance_volar := 0.33
@export var bonus_evasion_volar := 0.5

var estado := Estado.Neutral

func ejecutar_estado() -> void:
	pass

func avance_fsm() -> void:
	match (estado):
		Estado.Neutral:
			estado = Estado.Volar if randf() < chance_volar else Estado.PrePicotazo
			get_parent().evasion = bonus_evasion_volar
		Estado.Volar:
			estado = Estado.PreAtkVolar
		Estado.PreAtkVolar:
			ataque_volador()
			estado = Estado.Neutral
		Estado.PrePicotazo:
			ataque_picotazo()
			estado = Estado.Neutral

func ataque_volador():
	AtaqueManager.atacar_jugador(floor(monstruo.damage * 1.5))

func ataque_picotazo():
	AtaqueManager.atacar_jugador(floor(monstruo.damage))
