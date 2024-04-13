extends Node2D
class_name Console

@export var pergunta : Perguntas

@onready var pesquisa = $Pesquisa
@onready var status = $Status

var natureza
var topico

var resposta

@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	_nova_pergunta()

func _nova_pergunta():
	status.text = "Aguardando resposta..."
	var quest : Dictionary = pergunta._get_pergunta()
	natureza = quest["natureza"]
	topico = quest["topico"]
	pesquisa.text = quest["pergunta"]
	
func _checa_resposta(nat, top):
	timer.start()
	
	status.text = "Analizando..."
	
	await timer.timeout
	
	if nat == natureza and top == topico:
		status.text = "Enviado!"
	else:
		status.text = "Erro! Informação errada!"
		
	timer.start()
	
	await timer.timeout
	
	_nova_pergunta()
