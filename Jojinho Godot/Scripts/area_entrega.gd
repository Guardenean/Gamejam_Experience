extends Area2D

@export var console : Console
@onready var timer = $Timer

func _on_body_entered(body):
	if body.is_in_group("Caixas"):
		timer.start()
		await timer.timeout
		console._checa_resposta(body.natureza, body.topico)
		body.queue_free()
