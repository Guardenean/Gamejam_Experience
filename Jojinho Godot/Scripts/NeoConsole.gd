extends Node2D
#class_name Console

@export var pergunta : Perguntas

@onready var pesquisa = $Panel/MPrincipal/Pesquisa
@onready var status = $Panel/MPrincipal/Status
@onready var pontuacao = $MPontuacao/Pontuacao
@onready var timer = $Timer
@onready var timer_Text = $TimerText

var natureza
var topico
var resposta

var acertou : bool 
var errou : bool

@onready var vidas : int = 3
@onready var tentativas = $Tentativas/Htentativas
var minuto_zero = 0
var segundo_zero = 0

@onready var pontos : int = 0

func _ready():
	# Pega uma pergunta no início do jogo
	timer.start()
	_nova_pergunta()


func _process(_delta):
	pontuacao.text = str(pontos)
	tempo_de_resposta()
	#timer_Text = "%02d:%02d" % tempo_de_resposta()
	

# Pede uma nova pergunta
func _nova_pergunta():
	status.text = "Aguardando resposta...".to_upper()
	var quest : Dictionary = pergunta._get_pergunta()
	natureza = quest["natureza"]
	topico = quest["topico"]
	pesquisa.text = quest["pergunta"].to_upper()

# Checa a se respota enviada está certa
func _checa_resposta(nat, top):
	timer.start()
	status.to_upper()
	status.text = "Analizando...".to_upper()
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
		tempo_de_resposta()
	# Senão, aplique a morte
	else:
		_morte()

func _acerto():
	status.to_upper()
	status.text = "Enviado!".to_upper()
	# Texto verde 
	pontos += 100
	$TimerJogo.start()
	
	
func _erro():
	status.text = "Erro! Informação errada!".to_upper()
	# Texto vermelho
	vidas -= 1
	pontos -= 50
	tentativas.get_child(tentativas.get_child_count(false) - 1).queue_free()
	$TimerJogo.start()
	

func _morte():
	print("Mortin da Silva")
	timer.start()
	await  timer.timeout
	get_tree().reload_current_scene()
	
func tempo_de_resposta():
	
	var tempo_restante =  roundf($TimerJogo.time_left)
	var minutos = floor(tempo_restante/60)
	var segundos = int(tempo_restante) % 60
	$TimerText.text = "%02d:%02d" % [minutos, segundos]
	
func _on_timer_jogo_timeout():
	_erro()
	print("perdeu vida tempo")
	$TimerJogo.start()
	print("resetou tempo")


