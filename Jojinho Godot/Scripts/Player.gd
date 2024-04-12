extends CharacterBody2D
class_name Player


var SPEED = 400.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var timer = $Timer
@onready var anim = $AnimatedSprite2D


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		
		if direction == -1:
			anim.flip_h = true
		else: anim.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	#ANIMAÇÃO!!!!!!!!!!!!!!!!!!!!
	if direction and is_on_floor():
		anim.play("Run")
	elif !is_on_floor() and velocity.y < 0:
		anim.play("Jump")
	elif !is_on_floor() and velocity.y > 0:
		anim.play("Fall")
	elif is_on_floor() and velocity.y == 0:
		anim.play("Idle")
		

	move_and_slide()


func _on_timer_timeout():
	SPEED = 400.0
