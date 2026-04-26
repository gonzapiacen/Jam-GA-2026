extends Sprite2D
@export var hijo1: Node
@export var hijo2: Node
@export var raiz: Node
var hijos = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if hijo1:
		hijos.append(hijo1)
	if hijo2:
		hijos.append(hijo2)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _activateNodes()  -> void:
	for i in range(hijos.size()):
		(hijos[i].get_child(0) as Button).disabled = false

func _disableNodes() -> void:
	for i in range(hijos.size()):
		(hijos[i].get_child(0) as Button).disabled = true


func _on_button_pressed() -> void:
	(self.get_child(0) as Button).disabled = true
	_activateNodes()
