extends CharacterBody2D
class_name Player

# Variáveis
var SPEED = 500.0
const JUMP_VELOCITY = -500.0
var _super : bool = false

@onready var timer = $Timer
@onready var super_timer = $SuperTimer
@onready var anim = $AnimatedSprite2D
@onready var pivot_box = $PivotBox
@onready var area_interact = $AreaInteract
@onready var camera = $Camera2D
@onready var bg : Sprite2D = $Camera2D/BG

@onready var sfx_run = $SFX_Run
@onready var sfx_pulo = $SFX_Pulo
@onready var bgm = $BGM
@onready var sfx_super = $SFX_Super

var itemInteract

@export var ghost_node : PackedScene
@onready var morto : bool = false

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Funções
# TESTE DO SUPER POWER UP
func _unhandled_input(_event):
	if Input.is_action_just_pressed("teste"):
		_go_super()

func _physics_process(delta):
	if morto:
		bgm.stop()
		return
	
	if !bgm.playing and _super == false:
		bgm.play()
	
	match _super:
		false:
			_player_normal(delta)
		true:
			_player_super()
	
	#Chamando função de interação
	_interact()

	#Aplica movimento (SEMPRE DEIXAR ISSO NO FINAL DO PHYSICS PROCESS)
	move_and_slide()

# MOVIMENTO PLAYER NORMAL
func _player_normal(delta):
	# Gravidade
	if not is_on_floor():
		velocity.y += gravity * delta

	# Calcula pulo
	if Input.is_action_just_pressed("pulo") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		sfx_pulo.play()

	# Pega direção de movimento do input
	var direction = Input.get_axis("esquerda", "direita")
	# Checa se houve input
	if direction:
		if is_on_floor() and !sfx_run.playing:
			sfx_run.play()
			
		velocity.x = direction * SPEED
		
		if direction == -1:
			anim.flip_h = true
			area_interact.position.x = -18
			camera.drag_horizontal_offset = lerp(camera.drag_horizontal_offset, -.2, .1)
		else:
			anim.flip_h = false
			area_interact.position.x = 18
			camera.drag_horizontal_offset = lerp(camera.drag_horizontal_offset, .2, .1)
		bg.offset.x = lerp(bg.offset.x, camera.drag_horizontal_offset * 200, 1.0)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		camera.drag_horizontal_offset = lerp(camera.drag_horizontal_offset, .0, .1)
		bg.offset.x = lerp(bg.offset.x, camera.drag_horizontal_offset * 200, 1.0)
		sfx_run.stop()
	
	#ANIMAÇÃO!!!!!!!!!!!!!!!!!!!!
	if direction and is_on_floor():
		anim.play("Run")
	elif !is_on_floor() and velocity.y < 0:
		anim.play("Jump")
	elif !is_on_floor() and velocity.y > 0:
		anim.play("Fall")
	elif is_on_floor() and velocity.y == 0:
		anim.play("Idle")
	

# MOVIMENTO PLAYER POWER UP
func _player_super():
	# Pega direção de movimento do input
	var direction : Vector2 = Vector2.ZERO
	direction.x = int(Input.is_action_pressed("direita")) - int(Input.is_action_pressed("esquerda"))
	direction.y = int(Input.is_action_pressed("baixo")) - int(Input.is_action_pressed("pulo"))
	direction.normalized()
	
	if direction:
		velocity = direction * SPEED
		
		if direction.x == -1:
			anim.flip_h = true
			
			area_interact.position.x = -18
		else:
			anim.flip_h = false
			
			area_interact.position.x = 18
	else:
		velocity = Vector2.ZERO

# TIMEOUT do Timer (POWER-UP)
func _on_timer_timeout():
	SPEED = 400.0
	
# Interação
func _interact():
	#Checa se pressionou input de interação
	if Input.is_action_pressed("interagir"):
		#Checa se há objeto para interagir
		if itemInteract != null:
			#Prende o objeto no player
			pivot_box.node_b = itemInteract.get_path()
			if _super:
				itemInteract._desliga_colisao()
				pivot_box.length = 0
	
	#Checa se soltou input de interação
	if Input.is_action_just_released("interagir"):
		#Solta o objeto (Player conecta a si mesmo)
		pivot_box.node_b = get_path()
		if itemInteract != null:
			itemInteract._liga_colisao()
			pivot_box.length = 2

#Checa se objeto entrou na area de interação
func _on_area_interact_body_entered(body):
	if body.is_in_group("Caixas") and itemInteract == null:
		itemInteract = body

#Checa se objeto saiu da area de interação
func _on_area_interact_body_exited(body):
	if body.is_in_group("Caixas") and !Input.is_action_pressed("interagir"):
		itemInteract = null

func _go_super():
	bgm.stop()
	sfx_super.play()
	_super = true
	super_timer.start()
	SPEED = 800.0
	$CollisionShape2D.set_deferred("disabled", true)
	$GhostTimer.start()
	anim.play("Super")

func _on_super_timer_timeout():
	sfx_super.stop()
	bgm.play()
	_super = false
	SPEED = 500.0
	$CollisionShape2D.set_deferred("disabled", false)
	$GhostTimer.stop()

func add_ghost():
	if morto: return
	
	var ghost = ghost_node.instantiate()
	ghost.set_property(position, anim.flip_h)
	get_tree().current_scene.add_child(ghost)

func _on_ghost_timer_timeout():
	add_ghost()
