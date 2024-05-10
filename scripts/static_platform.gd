extends Area2D

func _on_body_entered(body):
	if body is Player:
			body.jump();
			await get_tree().create_timer(1).timeout
			queue_free()
