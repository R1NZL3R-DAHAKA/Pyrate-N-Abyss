extends Area2D

@export var escena :String

func _on_body_entered(body):
	if body.name == "Player2D":
		get_tree().change_scene_to_file(escena)
	pass # Replace with function body.
