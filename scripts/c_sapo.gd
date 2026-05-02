extends Comportamiento
class_name CompSapo

enum Estado{
	Neutro,
	PreAtk,
	Defensa,
	Regeneracion
}
var estado:= Estado.Neutro
var contador: int = 0
@export var chance_regeneracion: float = 0.33
@export var regeneracion: int = 5

func ejecutar_estado() -> void:
	pass

func avance_fsm() -> void:
	match (estado):
		Estado.Neutro:
			if randf() < chance_regeneracion:
				estado = Estado.Regeneracion
			else:
				estado = Estado.PreAtk
		Estado.Regeneracion:
			regenerar()
			estado = Estado.Neutro
		Estado.PreAtk:
			ataque()
			estado = Estado.PreAtk

func regenerar():
	monstruo.health += regeneracion

func ataque():
	AtaqueManager.atacar_jugador(monstruo.damage)
