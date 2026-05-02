extends Node
class_name Enemy

@export var enemy_name: String
@export var health: int
@export var damage: int
@export var defense: int
@export var player: Player

signal ataque_enemigo_realizado

func take_turn() -> void:
	attack()

func attack() -> void:
	player.modified_health(-damage)
	emit_signal("ataque_enemigo_realizado")

func defend() -> void:
	pass

func buff() -> void:
	pass

func am_i_death() -> bool:
	return health <= 0
