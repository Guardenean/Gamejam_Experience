extends CharacterBody2D
class_name Player

# Variáveis
var SPEED = 400.0
const JUMP_VELOCITY = -400.0

@onready var timer = $Timer
@onready var anim = $AnimatedSprite2D
@onready var pivot_box = $PivotBox
@onready var area_interact = $AreaInteract
@onready var camera = $Camera2D

var itemInteract

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Funções

func _physics_process(delta):
	# Gravidade
	if not is_on_floor():
		velocity.y += gravity * delta

	# Calcula pulo
	if Input.is_action_just_pressed("pulo") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	
	# Pega direção de movimento do input
	var direction = Input.get_axis("esquerda", "direita")
	# Checa se houve input
	if direction:
		velocity.x = direction * SPEED
		
		if direction == -1:
			anim.flip_h = true
			area_interact.position.x = -18
			camera.drag_horizontal_offset = lerp(camera.drag_horizontal_offset, -.2, .1)
		else:
			anim.flip_h = false
			area_interact.position.x = 18
			camera.drag_horizontal_offset = lerp(camera.drag_horizontal_offset, .2, .1)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		camera.drag_horizontal_offset = lerp(camera.drag_horizontal_offset, .0, .1)
	
	#ANIMAÇÃO!!!!!!!!!!!!!!!!!!!!
	if direction and is_on_floor():
		anim.play("Run")
	elif !is_on_floor() and velocity.y < 0:
		anim.play("Jump")
	elif !is_on_floor() and velocity.y > 0:
		anim.play("Fall")
	elif is_on_floor() and velocity.y == 0:
		anim.play("Idle")
	
	#Chamando função de interação
	_interact()

	#Aplica movimento (SEMPRE DEIXAR ISSO NO FINAL DO PHYSICS PROCESS)
	move_and_slide()

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
	
	#Checa se soltou input de interação
	if Input.is_action_just_released("interagir"):
		#Solta o objeto (Player conecta a si mesmo)
		pivot_box.node_b = get_path()

#Checa se objeto entrou na area de interação
func _on_area_interact_body_entered(body):
	if body.is_in_group("Caixas"):
		itemInteract = body

#Checa se objeto saiu da area de interação
func _on_area_interact_body_exited(body):
	if body.is_in_group("Caixas"):
		itemInteract = null
