extends Label
@onready var perguntas = $Perguntas

# Called when the node enters the scene tree for the first time.
func _ready():
	text = perguntas.esporte.Pergunta3
	pass
