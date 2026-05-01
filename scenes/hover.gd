extends Control

@export var display_carta: TextureRect
@export var nombre_carta: Label
@export var descripcion_carta: Label
@export var coste_carta: Label
@export var efectos_carta: Label

func mostrar_hover(carta: Carta) -> void:
	display_carta.show()
	display_carta.texture = carta.texture
	nombre_carta.text = carta.nombre
	descripcion_carta.text = carta.descripcion
	coste_carta.text = carta.coste
	efectos_carta.text = carta.serializar_efecto()

func ocultar_hover() -> void:
	display_carta.hide()
