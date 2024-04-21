extends Node2D
class_name Console

@export var player : Player
@export var pergunta : Perguntas

@onready var pesquisa = $Panel/MPrincipal/Pesquisa
@onready var status = $Panel/MPrincipal/Status
@onready var pontuacao = $MPontuacao/Pontuacao
@onready var timer = $Timer
@onready var timer_Text = $TimerText

var natureza
var topico
var resposta

@onready var vidas : int = 3
@onready var tentativas = $Tentativas/Htentativas

@onready var pontos : int = 0

@onready var sfx_correto = $SFX_Correto
@onready var sfx_errado = $SFX_Errado

func _ready():
	$TimerJogo.start()
	# Pega uma pergunta no início do jogo
	_nova_pergunta()

func _process(_delta):
	pontuacao.text = str(pontos)
	tempo_de_resposta()

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
	sfx_correto.play()
	status.text = "Enviado!".to_upper()
	# Texto verde
	pontos += 100
	$TimerJogo.stop()
	if pergunta._get_array_count() > 0:
		$TimerJogo.start()
		return
	_vitoria()
		
	
func _erro():
	sfx_errado.play()
	status.text = "Erro! Informação errada!".to_upper()
	# Texto vermelho
	vidas -= 1
	pontos -= 50
	if pontos < 0:
		pontos = 0
	tentativas.get_child(tentativas.get_child_count(false) - 1).queue_free()
	$TimerJogo.stop()
	$TimerJogo.start()
	

func _morte():
	player.set_deferred("morto", true)
	player.anim.play("Fear")
	timer.start()
	await  timer.timeout
	
	player.anim.play("Off")
	timer.start()
	await  timer.timeout
	
	player.anim.play("Death")
	timer.start()
	await  timer.timeout
	get_tree().change_scene_to_file("res://Cenas/Import/GameOver.tscn")

func tempo_de_resposta():
	var tempo_restante =  roundf($TimerJogo.time_left)
	var minutos = floor(tempo_restante/60)
	var segundos = int(tempo_restante) % 60
	$TimerText.text = "%02d:%02d" % [minutos, segundos]
	
func _on_timer_jogo_timeout():
	_erro()
	$TimerJogo.start()
	_nova_pergunta()

func _vitoria():
	get_tree().change_scene_to_file("res://Cenas/TelaVitoria.tscn")
