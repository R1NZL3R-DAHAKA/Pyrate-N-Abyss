extends Node2D

@onready var AnimationPixel: AnimationPlayer = $AnimationPixel
@onready var AnimationEndless: AnimationPlayer = $AnimationEndless
@onready var AnimationImg: AnimationPlayer = $AnimationImg

func _ready():
	# Escondemos la escena del menú (corregido el comentario)
	#falseHealthDashboard.visible = false
	# Mostramos el logo de Endless
	AnimationEndless.play("do_splash")


# Escuchamos el teclado
func _input(event):
	# Escuchamos si se presiona algún botón
	if event is InputEventKey:
		# Llamamos a la función de cambio de escena
		_go_title_screen()

func _go_title_screen():
	
	get_tree().change_scene_to_file("res://Scenes/Menu/menu.tscn")

func _on_animation_endless_animation_finished(anim_name):
	# Al terminar la animación de AnimationEndless, comenzamos la de AnimationPlayer1
	AnimationPixel.play("do_splash")
	AnimationImg.play("do_img")
	
func _on_animation_pixel_animation_finished(anim_name):
	# Cambiamos la escena al finalizar la animación de AnimationPixel
	_go_title_screen()
