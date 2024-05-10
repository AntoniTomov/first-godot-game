extends Area2D

@onready var sprite_2d = $Sprite2D




func _on_body_entered(body):
	if body is Player:
		body.boost_velocity()
			
			
			
			
			
		#if body.jump_velocity == body.stable_velocity:
			#pass
		queue_free()
			#sprite_2d.visible = false
			
			

