extends Node2D

var turno_jugador: bool = false

# ESCENAS
const ESCENA_CARTA = preload("res://scenes/carta.tscn")

# NODOS
@onready var jugador: Player = $Jugador
@onready var enemigo: Enemy = $Enemigo
@onready var boton_pasar_turno: Button = $CampoCartas/PasarTurno
var nodo_carta_seleccionada: Carta2D = null

# INSTANCIAS



#var carta_esta_seleccionada: bool = false

func _ready() -> void:
	
	jugador.mazo = $Jugador/Mazo.inicializar()
	enemigo.player = jugador
	_actualizar_vida_jugador()
	enemigo.ataque_enemigo_realizado.connect(_actualizar_vida_jugador)
	presentacion_enemigo()
	
func presentacion_enemigo() -> void:
	
	var carta_enemigo = $Enemigo/Carta
	
	await get_tree().create_timer(3.0).timeout # PAUSA DRAMATICA
	carta_enemigo.reparent($Enemigo/Campo/Opcion2,false)
	carta_enemigo.position = Vector2(31,41)
	enemigo.get_node("Campo/Opcion2/").disabled = true
	enemigo.get_node("Campo/Opcion2/").show()
	await get_tree().create_timer(3.0).timeout
	voltear_carta(carta_enemigo)
	await get_tree().create_timer(3.0).timeout
	cambiar_turno()
	
func empieza_turno_jugador() -> void:
	
	#jugador.colocar_descarte_en_mazo()
	for i in range(3):
		await acomodar_carta_en_mano()
		
	print("DECIDIR SI JUGAR CARTAS O PASAR")

func acomodar_carta_en_mano() -> void:
	print("carta nueva")
	var carta_robada = jugador.mazo.robar_carta()
	
	#VISUAL
	
	var visual_carta_robada = crear_visual_carta(carta_robada,$Jugador/Mazo)
	await get_tree().create_timer(.3).timeout # PAUSA DRAMATICA
	voltear_carta(visual_carta_robada)
	visual_carta_robada.reparent($Jugador/Mano)
	visual_carta_robada.position = Vector2(0,0)
	#jugador.mano.push_back(visual_carta_robada)
	
	for i in range($Jugador/Mano.get_child_count()):
		$Jugador/Mano.get_children()[i].position.x = (($Jugador/Mano.get_child_count()/2) - i) * 50
		
func crear_visual_carta(c: Carta, n: Node2D) -> Carta2D:
	var instancia = ESCENA_CARTA.instantiate()
	instancia.set_carta(c)
	n.add_child(instancia)
	instancia.enviar_al_campo.connect(_mostrar_opciones)
	return instancia
	
func _mostrar_opciones(nodo_carta: Carta2D):
	
	if(jugador.tiene_campo_lleno()):
		print("Campo lleno")
		return

	if !nodo_carta_seleccionada:
		#carta_esta_seleccionada = true
		nodo_carta_seleccionada = nodo_carta
		nodo_carta_seleccionada.position.y -= 20

		boton_pasar_turno.hide()
		for slot_enemigo in $Enemigo/Campo.get_children():
			if slot_enemigo.get_child_count() == 1 :
				slot_enemigo.disabled = false
		for slot_player in $Jugador/Campo.get_children():
			if slot_player.get_child_count() == 0:
				slot_player.show()

	elif (nodo_carta_seleccionada == nodo_carta):
		#carta_esta_seleccionada = false
		nodo_carta_seleccionada.position.y += 20
		nodo_carta_seleccionada = null
		
		boton_pasar_turno.show()
		for slot_player in $Jugador/Campo.get_children():
			if slot_player.get_child_count() == 0:
				slot_player.hide()
		
		for slot_enemigo in $Enemigo/Campo.get_children():
			if slot_enemigo.get_child_count() == 1:
				slot_enemigo.disabled = true
	else:
		nodo_carta_seleccionada.position.y += 20
		nodo_carta_seleccionada = nodo_carta
		nodo_carta_seleccionada.position.y -= 20
	
func _elegir_enemigo():
	var eleccion = await $Enemigo/Campo/Area2D
	pass

func _aplicar_accion():
	pass
	
func voltear_carta(n: Node2D) -> void:
	n.get_node("Dorso").scale.x = 0
	n.get_node("Frente").scale.x = 1
	
func empieza_turno_enemigo() -> void:
	await get_tree().create_timer(3.0).timeout # PAUSA DRAMATICA
	print("ENEMIGO ATACA")
	enemigo.attack()
	await get_tree().create_timer(3.0).timeout # PAUSA DRAMATICA
	cambiar_turno()
	
func cambiar_turno() -> void:
	turno_jugador = !turno_jugador
	
	if turno_jugador:
		if(jugador.am_i_death()):
			await call_deferred("_ir_a_creditos")
		print("TURNO JUGADOR")
		await empieza_turno_jugador()
		boton_pasar_turno.show()
	else:
		boton_pasar_turno.hide()
		print("TURNO ENEMIGO")
		descartar()
		empieza_turno_enemigo()
		
func _ir_a_creditos():
	get_tree().change_scene_to_file("res://scenes/creditos.tscn")
	

func descartar():
	for nodo_carta_en_mano in $Jugador/Mano.get_children():
		jugador.descartar_carta(nodo_carta_en_mano.carta)
		
		# VISUAL
		
		nodo_carta_en_mano.reparent($Jugador/Descarte)
		nodo_carta_en_mano.position = Vector2(0,0)
		
		nodo_carta_en_mano.enviar_al_campo.disconnect(_mostrar_opciones)
		await get_tree().create_timer(.7).timeout # PAUSA DRAMATICA

func _on_pasar_turno_pressed() -> void:
	jugador.descartar_mano()
	cambiar_turno()

func _on_enemy_slot_pressed(id) -> void:
	print("SLOT: ", (id+1), " DEL ENEMIGO")

func _on_player_slot_pressed(id) -> void:
	print("SLOT: ", (id+1), " DEL JUGADOR")
	
	jugador.jugar_carta_campo(nodo_carta_seleccionada.carta, id)
	
	nodo_carta_seleccionada.reparent($Jugador/Campo.get_children()[id], false)
	nodo_carta_seleccionada.position = Vector2(31,41)
	
	$Jugador/Campo.get_children()[id].disabled = true
	
	nodo_carta_seleccionada = null
	#carta_esta_seleccionada = false
	
	boton_pasar_turno.show()
	#$Enemigo/Campo.hide()
	#$Jugador/Campo.hide()
	
	for slot_player in $Jugador/Campo.get_children():
		if slot_player.get_child_count() == 0:
			slot_player.hide()

func _actualizar_vida_jugador():
	$UI/HP.text = str(jugador.health)
	$UI/ENG.text = str(jugador.energy)
