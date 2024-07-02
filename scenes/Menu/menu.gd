extends Control

@onready var AnimationButton: AnimationPlayer = $AnimationButton

func _ready():
	AnimationButton.play("do_animation")

func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menu/game.tscn")


func _on_options_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menu/options.tscn")


func _on_quit_pressed():
	get_tree().quit()


func _on_animation_button_animation_finished(anim_name):
	pass
	

