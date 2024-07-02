extends Node2D

#@onready var AnimationText: AnimationPlayer = $AnimationText
#@onready var AnimationImg: AnimationPlayer = $AnimationImg
@onready var AnimationCamera: AnimationPlayer = $AnimationCamera

# Called when the node enters the scene tree for the first time.
func _ready():
	#AnimationText.play("do_text")
	#AnimationImg.play("do_img")
	AnimationCamera.play("do_camera")

func _go_title_screen():
	
	get_tree().change_scene_to_file("res://scenes/game/maps_layers/Capa0_Island.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_animation_player_animation_finished(anim_name):
	pass # Replace with function body.


func _on_animation_img_animation_finished(anim_name):
	pass # Replace with function body.


func _on_animation_camera_animation_finished(anim_name):
	if anim_name == "do_camera":
		_go_title_screen()
