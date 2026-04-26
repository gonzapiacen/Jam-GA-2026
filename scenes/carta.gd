extends Node2D

class_name Carta

var nodo_frente: Sprite2D
var nodo_dorso: Sprite2D

var costeEnergia: int

var tween: Tween
var tweenY: int = 7

var detalles: String
var mostrarDetalles: bool = false
var es_consumible: bool

var energia: int
var energiaG: Label

var efecto: int
var efectoG: Label

var tipoEfecto: int
var tipoEfectoG: Sprite2D

signal ver_info
signal ocultar_info
signal jugar_carta
signal mostrar_info_carta_campo

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	nodo_frente = $Frente
	energiaG = nodo_frente.find_child("ValorEnergia")
	efectoG = nodo_frente.find_child("ValorEfecto")
	tipoEfectoG = nodo_frente.find_child("IconoEfecto")
	nodo_dorso = $Dorso
	
	nodo_frente.scale.x = 0
	
	detalles = "Detalles detallados"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_2d_mouse_entered() -> void:
	print(position.y)
	if tween:
		tween.kill()
		
	tween = create_tween()
	tween.tween_property($".","position",Vector2(0,position.y - (tweenY+15)),.2).set_ease(Tween.EASE_IN).as_relative()
	#position.y = tweenY-15
	#z_index = z_index + 1
	mostrarDetalles = true
	
	emit_signal("ver_info")
	
	await tween.finished

func _on_area_2d_mouse_exited() -> void:
	
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property($".","position",Vector2(0,tweenY - position.y),.2).set_ease(Tween.EASE_IN).as_relative()
	#position.y = tweenY
	#position.y = tweenY
	#z_index = z_index - 1
	mostrarDetalles = false
	emit_signal("ocultar_info")

	await tween.finished


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		emit_signal("jugar_carta",self)
