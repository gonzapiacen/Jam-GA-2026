extends Node2D
class_name Map
@export var nodes: Array[MapNode] = []

func _ready():
	nodes.assign(get_children())
	#var level: int = 0
	#for i in range(8):
		#var node = preload("res://scenes/map_node.tscn")
		#if i == 0:
			#node.position = Vector2(544,304)
			#node.level = level
			#level += 1
		#else: if (level % 2) == 0:
			#node.position = nodes[0].position + Vector2(0,32 * level)
			#node.level = level
		#else:
			#node.position = nodes[0].position + Vector2(0,32 * level)
		#
		#add_child(node)
		#nodes.append(node)
	## Example: create 3 nodes
	#var node1 = preload("res://scenes/map_node.tscn").instantiate()
	#node1.position = Vector2(100, 100)
	#add_child(node1)
	#nodes.append(node1)
#
	#var node2 = preload("res://scenes/map_node.tscn").instantiate()
	#node2.position = Vector2(300, 100)
	#add_child(node2)
	#nodes.append(node2)
#
	## Connect them
	#node1.connections.append(node2)
	#node2.connections.append(node1)
	#
func _draw():
	for node in nodes:
		for target in node.connections:
			draw_line(node.position, target.position, Color.WHITE, 2)

func _deactivated_level(level: int) -> void:
	var i = 0
	while i < nodes.size():
		if nodes[i].level == level:
			nodes[i]._activate_button(true)
			i += 1
		else: if nodes[i].level > level:
			i = nodes.size()
		else:
			i += 1
