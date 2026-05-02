extends Comportamiento
class_name CompJabali

enum Estado{
	Neutro,
	PreCornada,
	Defensa,
	PreCarga
}
var estado:= Estado.Neutro
var contador: int = 0
@export var chance_cornada: float = 0.33
@export var chance_carga: float = 0.33

func ejecutar_estado() -> void:
	pass

func avance_fsm() -> void:
	match (estado):
		Estado.Neutro:
			pass
			if randf() < chance_cornada:
				estado = Estado.PreCornada
			else: if randf() < chance_carga:
				estado = Estado.PreCarga
			else:
				estado = Estado.Defensa
		Estado.Defensa:
			defensa()
			estado = Estado.Neutro
		Estado.PreCornada:
			cornada()
			estado = Estado.Neutro
		Estado.PreCarga:
			if contador >= 3:
				carga()
				estado = Estado.Neutro
				contador = 0
			else:
				monstruo.defense += 3
				contador += 1

func cornada():
	AtaqueManager.atacar_jugador(monstruo.damage)

func carga():
	AtaqueManager.atacar_jugador(monstruo.damage*2)

func defensa():
	monstruo.defense = 6
