extends Area2D

@export var player : Player

func _on_body_entered(body):
	if body.is_in_group("Player"):
		body._go_super()
		queue_free()
