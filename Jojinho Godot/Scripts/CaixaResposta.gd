extends Node
class_name CaixaResposta

@export var natureza : String
@export var topico : String

func _desliga_colisao():
	$CollisionShape2D.set_deferred("disabled", true)

func _liga_colisao():
	$CollisionShape2D.set_deferred("disabled", false)
