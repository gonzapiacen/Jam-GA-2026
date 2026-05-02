extends Resource

class_name Carta

enum Tipo {
	Instantanea,
	Permanente
	}

# Características
@export var energia: int
@export var es_consumible: bool
@export var durabilidad: int
@export var detalles: String
@export var tipo: Tipo
