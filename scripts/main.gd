extends Node2D

var campo_jugador: Array[Carta] = []
var campo_enemigo: Array[Carta] = []

var carta = preload("res://scenes/carta.tscn")
var mazo = preload("res://scenes/mazo.tscn")
var enemy = preload("res://scenes/enemy.tscn")
var player = preload("res://scenes/player.tscn")
var nueva_carta: Carta

var cartas_jugador: Node2D

var musica_de_fondo: AudioStreamPlayer2D
var sonido_romper_carta: AudioStreamPlayer2D
var sonido_jugar_carta: AudioStreamPlayer2D

var info_carta: Node2D
var mano_jugador: Array[Carta]
var mazo_jugador: Mazo

var mano_nodo: Node2D
var descarte_nodo: Node2D
var campo_nodo: Node2D

var turno_jugador: bool = true

var tween: Tween

var monto: Array[Carta] = []
var descarte: Array[Carta] = []

var player_actual: Player
var enemigo_actual: Enemy

@onready var hp_label: Label = $UI/HP
@onready var eng_label: Label = $UI/ENG
@onready var enemy_hp_label: Label = $UI/EnemyHP


var boton_pasar_turno: Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	info_carta = $Mapa/InfoCarta
	boton_pasar_turno = $CampoCartas/PasarTurno
	
	boton_pasar_turno.pressed.connect(cambiarTurno)
	
	# COSAS JUGADOR
	
	mazo_jugador = $CampoCartas/Mazo
	mano_nodo = $CampoCartas/Mano
	descarte_nodo = $CampoCartas/Descarte
	campo_nodo = $CampoCartas/CartasJugador
	
	# MUSICA Y SONIDOS
	
	musica_de_fondo = $MusicaFondo
	sonido_romper_carta = $SonidoRomperCarta
	sonido_jugar_carta = $SonidoJugarCarta
	
	info_carta.hide()
	mazo_jugador = mazo.instantiate()
	mazo_jugador.position.x = 385
	mazo_jugador.position.y = 302
	add_child(mazo_jugador)
	
	player_actual = player.instantiate()
	hp_label.text =  str(player_actual.health)
	eng_label.text = str(player_actual.energy)
	
	
	#player_actual.health = 20
	#player_actual.energy = 10
	
	enemigo_actual = enemy.instantiate()
	enemy_hp_label.text = str(enemigo_actual.health)
	enemigo_actual.player = player_actual
	
	for i in range(mazo_jugador.monto.size()):
		nueva_carta = carta.instantiate()
		monto.append(nueva_carta)
	
	mazo_jugador.find_child("Valor").visible = true
	
	empezarTurno()
	
	musica_de_fondo.play()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func crearLadoJugador() -> void:
	pass
	
func empezarTurno() -> void:
	for i in range(3):
		nueva_carta = mazo_jugador.robarCarta()
		
		mano_nodo.add_child(nueva_carta)
		mano_jugador.append(nueva_carta)
		
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
	
func cambiarTurno() -> void:
	enviarCartasManoADescarte()
	print("TURNO ENEMIGO")
	turno_jugador = false
	
	await get_tree().create_timer(2).timeout
	ejecutarTurnoEnemigo()
	await get_tree().create_timer(2).timeout
	turno_jugador = true
	print("TU TURNO")
	empezarTurno()
	
func ejecutarTurnoEnemigo():
	print("Enemigo ha atacado")
	enemigo_actual.attack()
	hp_label.text = str(player_actual.health)
	print("Vida personaje: ", player_actual.health)
	print("Vida enemigo: ", enemigo_actual.health)
	
func enviarCartasManoADescarte() -> void:
	for hijo in mano_nodo.get_children():
		campo_jugador.erase(hijo)
		descarte.append(hijo)
		print(campo_jugador.size())
		hijo.reparent(descarte_nodo,false)
		hijo.position.x = 0
		hijo.position.y = 0
		hijo.scale.x = 1
		hijo.scale.y = 1
func eliminarCarta(carta: Carta) -> void:
	sonido_romper_carta.play()
	carta.queue_free()

func mostrarInfo() -> void:
	info_carta.show()

func ocultarInfo() -> void:
	info_carta.hide()

func jugarCarta(carta: Carta) -> void:
	if !turno_jugador:
		return
		
	if campo_jugador.size() == 3 :
		print("Campo lleno")
		return
	
	carta.position.x = -21 + (21 * campo_jugador.size())
	carta.position.y = -40
	campo_jugador.push_back(mano_jugador.pop_at(mano_jugador.find(carta)))
	sonido_jugar_carta.play()
	carta.jugar(player_actual,enemigo_actual)
	hp_label.text = str(player_actual.health)
	eng_label.text = str(player_actual.energy)
	enemy_hp_label.text = str(enemigo_actual.health)
	
	#if enemigo_actual.health <= 0:
		
