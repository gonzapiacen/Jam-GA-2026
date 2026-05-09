extends Carta

class_name CartaElemento

# Características
#@export var carta_res: CartaElementoRes
#@export var energia: int
#@export var es_consumible: bool
#@export var durabilidad: int
#@export var detalles: String
var tipo: Tipo
var efectos: Array[Efecto]

func _ready():
	_setear_valores()
	
	for efecto in $Efectos.get_children():
		efectos.append(efecto)

func _setear_valores():
	$Frente/Cantidad.text = str(carta_res.cantidad)
	$Frente/Dibujo.texture = carta_res.sprite
