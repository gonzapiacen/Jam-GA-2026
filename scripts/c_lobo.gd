extends Comportamiento
class_name CompLobo

enum Estado{
	Neutro,
	PreAtk,
	Defensa,
	PreFrenesi
}
var estado:= Estado.PreAtk
var contador: int = 0
@export var chance_defensa: float = 0.33
@export var chance_frenesi: float = 0.70
@export var defensa: int = 3

func ejecutar_estado() -> void:
	pass

func avance_fsm() -> void:
	match(estado):
		Estado.Neutro:
			if monstruo.max >= monstruo.max_health/2.0 and randf() < chance_defensa: 
				estado = Estado.Defensa
			else: if monstruo.health < monstruo.max_health/2.0 and randf() < chance_frenesi:
				estado = Estado.PreFrenesi
			else:
				Estado.PreAtk
		Estado.Defensa:
			defender()
			estado = Estado.Neutro
		Estado.PreAtk:
			ataque()
			estado = Estado.Neutro
		Estado.PreFrenesi:
			if contador >= 2:
				frenesi()
				estado = Estado.Neutro
				contador = 0
			else:
				contador += 1

func ataque():
	AtaqueManager.atacar_jugador(monstruo.damage)
func frenesi():
	for i in range(3):
		AtaqueManager.atacar_jugador(monstruo.damage)
func defender():
	monstruo.defense = defensa
