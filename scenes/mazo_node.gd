extends Node2D

class_name Mazo2D

@onready var cartas_label : Label = $Cartas
@onready var mazo: Mazo = $Mazo

func _ready() -> void:
	mazo.inicializar()
	cartas_label.text = str(mazo.cartas.size())
	mazo.cambio_cantidad_cartas.connect(actualizar_cantidad)

func actualizar_cantidad():
	cartas_label.text = str(mazo.cartas.size())
