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

var enCampo: bool
var esConsumible: bool

var enDescarte: bool

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
	enCampo = false
	
	nodo_frente.scale.x = 0
	
	detalles = "Detalles detallados"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func jugar(player: Player,enemy: Enemy) -> void:
	print(tipoEfecto)
	if tipoEfecto == 0: #dano
		enemy.health -= efecto
	else: if tipoEfecto == 1: #vida
		player.modified_health(efecto)
	else: # energia
		player.modified_energy(efecto)

func _on_area_2d_mouse_entered() -> void:

	mover_carta(position.y - (tweenY+15))
	mostrarDetalles = true
	
	emit_signal("ver_info")
	
	await tween.finished

func _on_area_2d_mouse_exited() -> void:

	mover_carta(tweenY - position.y)
	
	mostrarDetalles = false
	emit_signal("ocultar_info")

	await tween.finished

func mover_carta(pos: int) -> void:
	if enCampo:
		return
		
	if tween:
		tween.kill()
		
	tween = create_tween()
	tween.tween_property($".","position",Vector2(0,pos),.2).set_ease(Tween.EASE_IN).as_relative()

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if enCampo:
		if tween:
			tween.kill()
		return
	
	if event is InputEventMouseButton and event.is_pressed():
		enCampo = true
		emit_signal("jugar_carta",self)
