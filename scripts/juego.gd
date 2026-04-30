extends Node2D

var turno_jugador: bool = false

# ESCENAS
const ESCENA_JUGADOR = preload("res://scenes/player.tscn")
const ESCENA_CARTA = preload("res://scenes/carta.tscn")

# NODOS
var jugador: Player
var enemigo: Enemy

func _ready() -> void:
	jugador = ESCENA_JUGADOR.instantiate()
	jugador.mazo = Mazo.new()
	jugador.mazo.inicializar()
	presentacion_enemigo()
	
func presentacion_enemigo() -> void:
	
	await get_tree().create_timer(2.0).timeout # PAUSA DRAMATICA
	print("ENEMIGO (CARTA BOCA ABAJO) SE MUEVE DEL MAZO AL CAMPO")
	print("ENEMIGO SE VE (CARTA BOCA ARRIBA)")
	print("SE MUESTRA VIDA DEL ENEMIGO")
	await get_tree().create_timer(2.0).timeout
	cambiar_turno()
	
func empieza_turno_jugador() -> void:
	jugador.colocar_descarte_en_mazo()
	for i in range(3):
		await acomodar_carta_en_mano()
		
	print("DECIDIR SI JUGAR CARTAS O PASAR")

func acomodar_carta_en_mano() -> void:
	print("carta nueva")
	var temp = crear_visual_carta(jugador.mazo.robar_carta(),$Jugador/Mazo)
	await get_tree().create_timer(.3).timeout # PAUSA DRAMATICA
	voltear_carta(temp)
	temp.reparent($Jugador/Mano)
	temp.position = Vector2(0,0)
	#jugador.mano.push_back(temp)
	
	for i in range($Jugador/Mano.get_child_count()):
		$Jugador/Mano.get_children()[i].position.x = (($Jugador/Mano.get_child_count()/2) - i) * 50
		
func crear_visual_carta(c: Carta, n: Node2D) -> Node2D:
	var instancia = ESCENA_CARTA.instantiate()
	instancia.set_carta(c)
	n.add_child(instancia)
	
	return instancia
	
func voltear_carta(n: Node2D) -> void:
	n.get_node("Dorso").scale.x = 0
	n.get_node("Frente").scale.x = 1
	
func empieza_turno_enemigo() -> void:
	await get_tree().create_timer(3.0).timeout # PAUSA DRAMATICA
	print("ENEMIGO ATACA")
	await get_tree().create_timer(3.0).timeout # PAUSA DRAMATICA
	cambiar_turno()
	
func cambiar_turno() -> void:
	turno_jugador = !turno_jugador
	
	if turno_jugador:
		print("TURNO JUGADOR")
		empieza_turno_jugador()
	else:
		print("TURNO ENEMIGO")
		empieza_turno_enemigo()
"""
ESTO AGREGARLO EN LA ESCENA PRINCIPAL PARA DIBUJAR LA CARTA
var carta_data = mazo.robar()
var carta_node = preload("res://CartaEscena.tscn").instantiate()

carta_node.set_datos(carta_data)
add_child(carta_node)
---
ESTO PRECARGA EL RECURSO CARTA SIN NECESIDAD DE HACERLO POR CODIGO (SOLO PARA REPETICIONES)
mazo.append(preload("res://cartas/carta_hielo.tres"))
---
"""

func _on_pasar_turno_pressed() -> void:
	jugador.descartar_mano()
	cambiar_turno()
