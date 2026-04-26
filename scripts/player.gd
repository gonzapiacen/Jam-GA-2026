extends Node
class_name Player

@export var health: int
@export var energy: int

func modified_health(i: int) -> void:
	health = health + i

func modified_energy(i: int) -> void:
	energy = energy + i
