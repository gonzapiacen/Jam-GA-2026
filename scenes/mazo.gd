extends Node2D

class_name Mazo
var cantCartas: Label

var carta = preload("res://scenes/carta.tscn")
var nuevaCarta: Carta
var sonido_robo_carta: AudioStreamPlayer2D
var sonido_carta_en_campo: AudioStreamPlayer2D

var monto: Array[Carta] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sonido_robo_carta = $RoboCarta
	sonido_carta_en_campo = $RoboCarta
	cantCartas = $CantidadCartas/Valor
	cantCartas.text = "20"
	
	for i in range (cantCartas.text.to_int()):
		nuevaCarta = carta.instantiate()
		
		nuevaCarta.energia = ((i % 9) + 1)
		monto.append(nuevaCarta)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func robarCarta() -> Carta:
	sonido_robo_carta.play()
	cantCartas.text = str(cantCartas.text.to_int()-1)
	var pos = randi()%monto.size()
	var carta = monto[pos]
	monto.pop_at(pos)
	return carta
	#$CantidadCartas/Valor.text = str(cantCartas)
	

func anadirCarta() -> void:
	sonido_robo_carta.play()
	cantCartas.text = str(cantCartas.text.to_int()+1)
	monto.append(carta.instantiate())
