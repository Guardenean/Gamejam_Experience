extends Node2D
class_name Console

@export var pergunta : Perguntas

@onready var pesquisa = $Pesquisa.text
@onready var status = $Status.text

var resposta

@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	_nova_pergunta()

func _nova_pergunta():
	status = "Aguardando resposta..."
	
func _checa_resposta(nat, top):
	timer.start()
	status = "Analizando..."
	await timer.timeout
	
