extends Node2D

var mano: Array[Carta] = []
var campo_jugador: Array[Carta] = []
var campo_enemigo: Array[Carta] = []

var carta = preload("res://scenes/carta.tscn")
var mazo = preload("res://scenes/mazo.tscn")
var nueva_carta: Carta

var cartas_jugador: Node2D

var musica_de_fondo: AudioStreamPlayer2D
var sonido_romper_carta: AudioStreamPlayer2D
var sonido_jugar_carta: AudioStreamPlayer2D

var info_carta: Node2D
var mano_jugador: Node2D
var mazo_jugador: Mazo

var turno_jugador: bool = true

var tween: Tween

var monto: Array[Carta] = []
var descarte: Array[Carta] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	info_carta = $Mapa/InfoCarta
	
	# COSAS JUGADOR
	
	mazo_jugador = $CampoCartas/Mazo
	mano_jugador = $CampoCartas/Mano
	
	# MUSICA Y SONIDOS
	
	musica_de_fondo = $MusicaFondo
	sonido_romper_carta = $SonidoRomperCarta
	sonido_jugar_carta = $SonidoJugarCarta
	
	info_carta.hide()
	mazo_jugador = mazo.instantiate()
	mazo_jugador.position.x = 385
	mazo_jugador.position.y = 302
	add_child(mazo_jugador)
	
	for i in range(mazo_jugador.monto.size()):
		nueva_carta = carta.instantiate()
		monto.append(nueva_carta)
	
	mazo_jugador.find_child("Valor").visible = true
	
	for i in range(3):
		nueva_carta = mazo_jugador.robarCarta()
		
		mano_jugador.add_child(nueva_carta)
		nueva_carta.ver_info.connect(mostrarInfo)
		nueva_carta.ocultar_info.connect(ocultarInfo)
		nueva_carta.jugar_carta.connect(jugarCarta)
		nueva_carta.mostrar_info_carta_campo.connect(mostrarInfo)
		nueva_carta.position.x = 40
		nueva_carta.position.y = -25
		tween = create_tween()
		tween.tween_property(nueva_carta,"position",Vector2(-54 + (i * 16),32),.2).as_relative()
		tween.tween_property(nueva_carta.find_child("Dorso"),"scale",Vector2(-1,0),.2).as_relative()
		tween.tween_property(nueva_carta.find_child("Frente"),"scale",Vector2(1,0),.2).as_relative()
		
		nueva_carta.scale.x = .286
		nueva_carta.scale.y = .508
		await tween.finished
		tween.kill()
	
	musica_de_fondo.play()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func crearLadoJugador() -> void:
	pass
	
func cambiarTurno() -> void:
	turno_jugador = !turno_jugador
	
func enviarCartaDescarte(carta: Carta) -> void:
	descarte.append(carta)
	
func eliminarCarta(carta: Carta) -> void:
	sonido_romper_carta.play()
	carta.queue_free()

func mostrarInfo() -> void:
	info_carta.show()

func ocultarInfo() -> void:
	info_carta.hide()

func jugarCarta(carta: Carta) -> void:
	if campo_jugador.size() == 3 :
		print("Campo lleno")
		return
	
	carta.position.x = -21 + (21 * campo_jugador.size())
	carta.position.y = -40
	campo_jugador.push_back(mano.pop_at(mano.find(carta)))
	sonido_jugar_carta.play()
