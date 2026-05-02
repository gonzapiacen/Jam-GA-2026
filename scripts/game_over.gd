extends Control

@onready var nodo_fondo_color := $ColorRect

@export var color_fondo := Color(0.0, 0.0, 0.0, 0.5)

func _ready() -> void:
	var tween = create_tween()
	nodo_fondo_color.color = Color(0.0,0.0,0.0,0.0)
	tween.tween_property(nodo_fondo_color, "color", color_fondo, 1)

func _on_retry():
	pass

func _on_main_menu():
	pass
