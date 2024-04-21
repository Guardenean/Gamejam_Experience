extends RigidBody2D
class_name CaixaResposta

@export var natureza : String
@export var topico : String

func _desliga_colisao():
	$CollisionShape2D.set_deferred("disabled", true)
	gravity_scale = 3.0

func _liga_colisao():
	$CollisionShape2D.set_deferred("disabled", false)
	gravity_scale = 0.5
