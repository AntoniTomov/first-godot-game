extends StaticBody2D


func _on_mouse_entered():
	await get_tree().create_timer(1).timeout
	queue_free()
	print("remove")
