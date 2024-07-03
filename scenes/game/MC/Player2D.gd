extends CharacterBody2D

@onready var ap = $AnimationPlayer
@onready var sprite = $Sprite2D

@export var attacking = false

const SPEED = 200.0
const JUMP_VELOCITY = -200
const DOUBLE_JUMP_VELOCITY = -180  # Velocidad para el doble salto

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 600
var can_jump = true  # Bandera para permitir el salto
var has_double_jumped = false  # Bandera para rastrear si ya se realizó el doble salto
var _jump_count = 0 # Contador de saltos realizados

func _process(delta):
	if Input.is_action_just_pressed("attack"):
		attack()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY  # Salto normal si está en el suelo
			can_jump = true  # Deshabilita el salto después del primer salto
			_jump_count += 1
		elif !has_double_jumped:
			velocity.y = DOUBLE_JUMP_VELOCITY  # Doble salto si ya está en el aire y no se ha realizado antes
			_jump_count += 1

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("move_left", "move_right")
	velocity.x = direction * SPEED
	if direction != 0:
		sprite.flip_h = (direction == -1)

	update_animations(direction)
	move_and_slide()
	print(velocity)
	
func attack():
	attacking = true
	ap.play("attack1")
	

func update_animations(direction):
	if !attacking:
		if direction != 0:
			ap.play("run")
		else:
			ap.play("idle")
		if velocity.y < 0:
			ap.play("jump")
		elif velocity.y > 0:
			ap.play("fall")	
