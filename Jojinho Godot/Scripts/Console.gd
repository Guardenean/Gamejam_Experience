extends Node2D
class_name Console

@export var pergunta : Perguntas

@onready var pesquisa = $Pesquisa
@onready var status = $Status
@onready var pontuacao = $Pontuacao
@onready var timer = $Timer

var natureza
var topico
var resposta

@onready var vidas : int = 3
@onready var tentativas = $Tentativas

@onready var pontos : int = 0

func _ready():
	# Pega uma pergunta no início do jogo
	_nova_pergunta()

func _process(_delta):
	pontuacao.text = "Pontuação: " + str(pontos)

# Pede uma nova pergunta
func _nova_pergunta():
	status.text = "Aguardando resposta..."
	var quest : Dictionary = pergunta._get_pergunta()
	natureza = quest["natureza"]
	topico = quest["topico"]
	pesquisa.text = quest["pergunta"]

# Checa a se respota enviada está certa
func _checa_resposta(nat, top):
	timer.start()
	status.text = "Analizando..."
	# Texto normal
	await timer.timeout
	
	if nat == natureza and top == topico:
		_acerto()
		# Toca som acerto
	else:
		_erro()
		# Toca som erro
	
	# Se o jogador ainda tiver vidas, pegue uma pergunta nova
	if vidas > 0:
		timer.start()
		await timer.timeout
		_nova_pergunta()
	# Senão, aplique a morte
	else:
		_morte()

func _acerto():
	status.text = "Enviado!"
	# Texto verde
	pontos += 100
	
func _erro():
	status.text = "Erro! Informação errada!"
	# Texto vermelho
	vidas -= 1
	pontos -= 50
	tentativas.get_child(tentativas.get_child_count(false) - 1).queue_free()
	

func _morte():
	print("Mortin da Silva")
	timer.start()
	await  timer.timeout
	get_tree().reload_current_scene()
