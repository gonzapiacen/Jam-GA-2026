extends Node2D

class_name Carta

enum Tipo { Instantanea,Permanente }

# Características
@export var carta_res: Resource
#@export var energia: int
#@export var es_consumible: bool
#@export var durabilidad: int
@export var detalles: String
#@export var tipo: Tipo
#var efectos: Array[Efecto]

#func _ready():
#	efectos.assign($Efectos.get_children())
