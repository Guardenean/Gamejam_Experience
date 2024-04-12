extends Area2D

@export var player : Player

func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.SPEED = 800.0
		body.timer.start()
		queue_free()
