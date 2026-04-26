extends Node
class_name Enemy

@export var enemy_name: String
@export var health: int
@export var damage: int
@export var defense: int
@export var player: Player

func attack() -> void:
	player.modified_health(-damage)

func defend() -> void:
	pass

func buff() -> void:
	pass
