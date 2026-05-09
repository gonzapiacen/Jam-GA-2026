extends Node2D
class_name Tablero

#@onready var mazo_jugador: Mazo = $MazoJugador
#@onready var mazo_enemigo: Mazo = $MazoEnemigo
@export var mazo_enemigo: Mazo
var campo_enemigo: Array[CartaEnemigo] = [null, null, null]

@export var mazo_jugador: Mazo
var mano: Array[CartaElemento] = []
var campo_jugador: Array[CartaElemento] = [null, null, null]
var descarte: Array[CartaElemento] = []

# ESCENAS
const ESCENA_LOBO = preload("res://scenes/cartas/enemigos/lobo.tscn")
const ESCENA_ALFAJOR = preload("res://scenes/cartas/elementos/alfajor.tscn")
const ESCENA_MEDIALUNA = preload("res://scenes/cartas/elementos/medialuna.tscn")
const ESCENA_FACON = preload("res://scenes/cartas/elementos/facon.tscn")
const ESCENA_PALO = preload("res://scenes/cartas/elementos/palo.tscn")

var turno_jugador: bool = true
var carta_mano_elegida: CartaElemento = null

func _ready():
	Globales.enemigos.clear()
	inicializar_enemigo()
	inicializar_jugador()
	
func inicializar_enemigo():
	mazo_enemigo.agregado_carta.connect(_modificar_monto_mazo.bind(mazo_enemigo))
	mazo_enemigo.robo_carta.connect(_mover_carta_mazo_a_campo)
	mazo_enemigo.sin_cartas.connect(_mazo_vacio.bind(mazo_enemigo))
	
	for opcion in $CampoEnemigo.get_children():
		opcion.disabled = true
	
	for i in range(1):
		var instancia_lobo = ESCENA_LOBO.instantiate()
		Globales.enemigos.append(instancia_lobo)
		mazo_enemigo.agregar_carta(instancia_lobo)
	
	await get_tree().create_timer(1.0).timeout
	while(!campo_enemigo_lleno() && !mazo_enemigo.mazo_vacio()):
		mazo_enemigo.robar_carta()
	
func inicializar_jugador():
	Globales.jugador = $Jugador
	
	mazo_jugador.agregado_carta.connect(_modificar_monto_mazo.bind(mazo_jugador))
	mazo_jugador.robo_carta.connect(_mover_carta_mazo_a_mano)
	mazo_jugador.sin_cartas.connect(_mazo_vacio.bind(mazo_jugador))
	Globales.jugador.muerto.connect(_ir_a_game_over)
	Globales.jugador.ap_cambio.connect(_modificar_ap_jugador)
	Globales.jugador.vida_cambio.connect(_modificar_vida_jugador)
	$PasarTurno.pressed.connect(_cambiar_turno)
	
	Globales.jugador.get_node("UI/HP").text = str($Jugador.get_vida())
	Globales.jugador.get_node("UI/ENG").text = str($Jugador.get_ap())

	var carta_creada
	for i in range(9):
		carta_creada = ESCENA_FACON.instantiate()
		mazo_jugador.agregar_carta(carta_creada)

	#for i in range(2):
	#	carta_creada = ESCENA_ALFAJOR.instantiate()
	#	mazo_jugador.agregar_carta(carta_creada)

	#for i in range(2):
	#	carta_creada = ESCENA_MEDIALUNA.instantiate()
	#	mazo_jugador.agregar_carta(carta_creada)

	mazo_jugador.mezclar()
	
	for i in range(3):
		await get_tree().create_timer(1.0).timeout
		robar_carta()
	
func _modificar_monto_mazo(mazo: Mazo):
	mazo.get_node("CantidadCartas").text = str(mazo.cartas.size())
	
func _mover_carta_mazo_a_campo(carta_robada: CartaEnemigo):
	var espacio_vacio
	for i in range(3):
		if(!campo_enemigo[i]):
			espacio_vacio = i
			break
	print("colocando enemigo en espacio: ", espacio_vacio)
	campo_enemigo[espacio_vacio] = carta_robada
	
	$MazoEnemigo.add_child(carta_robada)
	carta_robada.get_node("Dorso").scale.x = 0
	carta_robada.get_node("Frente").scale.x = .75
	
	await get_tree().create_timer(1.0).timeout
	carta_robada.reparent($CampoEnemigo.get_children()[espacio_vacio])

	$CampoEnemigo.get_children()[espacio_vacio].pressed.connect(_danar_enemigo.bind($CampoEnemigo.get_children()[espacio_vacio].get_children()[0]))
	$CampoEnemigo.get_children()[espacio_vacio].get_children()[0].estoy_muerto.connect(_borrar_enemigo_campo)
	carta_robada.position = Vector2(30.5,41) # MITAD DE TAMAÑO DE UNA CARTA PARA CENTRARLA EN EL AREA POR DONDE PASA EL MOUSE
	carta_robada.ejecutar_turno()
	_modificar_monto_mazo(mazo_enemigo)
	
func _ir_a_game_over():
	get_tree().call_deferred(
		"change_scene_to_file",
        "res://scenes/game_over.tscn"
	)
	
func _quedan_enemigos():
	if (!campo_enemigo[0] && !campo_enemigo[1] && !campo_enemigo[2] && mazo_enemigo.mazo_vacio()):
		$PasarTurno.disabled = true
		print("GANASTE, HIJO DE PERRA...")
	
func _borrar_enemigo_campo():
	campo_enemigo[0] = null
	Globales.enemigos[0].queue_free()
	_quedan_enemigos()
	
func _mover_carta_mazo_a_mano(carta_robada: CartaElemento):
	var nodo_control = Control.new()
	nodo_control.custom_minimum_size = Vector2(45, 75) # TAMAÑO DE LA CARTA
	nodo_control.mouse_filter = Control.MOUSE_FILTER_STOP
	nodo_control.mouse_entered.connect(_on_mouse_entered.bind(carta_robada))
	nodo_control.mouse_exited.connect(_on_mouse_exited.bind(carta_robada))
	nodo_control.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	
	carta_robada.get_node("Dorso").scale.x = 0
	nodo_control.add_child(carta_robada)
	nodo_control.gui_input.connect(_on_mouse_clicked.bind(carta_robada))
	$Jugador/Mazo/Monto.add_child(nodo_control)
	await get_tree().create_timer(1.0).timeout
	nodo_control.reparent($Jugador/Mano)
	carta_robada.position = Vector2(22.5,37.5) # MITAD DE TAMAÑO DE UNA CARTA PARA CENTRARLA EN EL AREA POR DONDE PASA EL MOUSE
	_modificar_monto_mazo(mazo_jugador)
	
func _danar_enemigo(enemigo: CartaEnemigo):
	
	for efecto in carta_mano_elegida.efectos:
		efecto.activar()
		
	carta_mano_elegida = null
	enemigo.get_parent().disabled = true
	
func _on_mouse_clicked(event, carta: CartaElemento):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if !carta_mano_elegida:
				carta_mano_elegida = carta
				for i in range(campo_enemigo.size()):
					if(campo_enemigo[i]):
						$CampoEnemigo.get_children()[i].disabled = false
			else:
				carta_mano_elegida = null
				for i in range(campo_enemigo.size()):
					if(campo_enemigo[i]):
						$CampoEnemigo.get_children()[i].disabled = true
					
func _on_mouse_entered(carta_a_ver: Carta):
	carta_a_ver.position.y -= 20

func _on_mouse_exited(carta_a_ver: Carta):
	carta_a_ver.position.y += 20
	
func _mazo_vacio(mazo: Mazo):
	mazo.get_node("Monto").visible = false
	
func _modificar_ap_jugador():
	Globales.jugador.get_node("UI/ENG").text = str($Jugador.get_ap())
	
func _modificar_vida_jugador():
	Globales.jugador.get_node("UI/HP").text = str($Jugador.get_vida())
	
func _cambiar_turno():
	turno_jugador = !turno_jugador
	
	if(turno_jugador):
		$PasarTurno.disabled = false
		print("Es el turno del jugador")
	else:
		$PasarTurno.disabled = true
		print("Cuidado con los monstruos")
		ejecutar_turno_enemigo()
		
func ejecutar_turno_enemigo():
	for enemigo in Globales.enemigos:
		await get_tree().create_timer(2.0).timeout
		enemigo.ejecutar_turno()
		await get_tree().create_timer(2.0).timeout
		
	_cambiar_turno()

func campo_jugador_lleno() -> bool:
	return (campo_jugador[0] && campo_jugador[1] && campo_jugador[2])

func campo_enemigo_lleno() -> bool:
	return (campo_enemigo[0] && campo_enemigo[1] && campo_enemigo[2])

func descartar_mano():
	for carta in mano:
		descartar_carta(carta)
		
func descartar_carta(carta: Carta):
	mano.erase(carta)
	descarte.push_back(carta)
	
func robar_carta() -> Carta:
	var temp = mazo_jugador.robar_carta()
	mano.append(temp)
	return temp

func colocar_descarte_en_mazo():
	mazo_jugador.cartas.append_array(descarte)
	mazo_jugador.shuffle()
	descarte.clear() 

func jugar_carta_campo(c: Carta, pos: int):
	mano.erase(c)
	campo_jugador[pos] = c
