extends Carta2D
class_name Enemy

@export var textura: Texture2D
@export var nombre: String
@export var descripcion: String
@export var max_health: int
@export var health: int
@export var damage: int
@export var defense: int

@export var comportamiento: Comportamiento

func ejecutar_turno() -> void:
	pass

func elegir_comportamiento() -> void:
	pass
	
func restar_vida(cantidad: int):
	health -= cantidad

func esta_muerto() -> bool:
	return health <= 0
