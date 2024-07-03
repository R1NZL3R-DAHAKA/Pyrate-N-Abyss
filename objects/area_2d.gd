extends Area2D



func _on_body_entered(body):
	queue_free()
	pass


func _on_animated_sprite_2d_animation_finished():
	await get_tree().create_timer(2).timeout
	# Eliminamos el objeto recogido de la escena
	queue_free()
