# MapNode.gd
extends Node2D
class_name MapNode

@export var node_type: String
@export var level: int
@export var connections: Array[MapNode] = []
@export var button: Button
@export var map: Map
@export var active: bool

func _ready() -> void:
	button.disabled = !active

func _activate_sons() -> void:
	for son in range(connections.size()):
		connections[son]._activate_button(false)

func _activate_button(active: bool) -> void:
	button.disabled = active

func _on_button_pressed() -> void:
	pass # Replace with function body.
	self._activate_sons()
	map._deactivated_level(level)
	
