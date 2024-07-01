extends CharacterBody2D

@onready var ap = $AnimationPlayer
@onready var sprite = $Sprite2D

const SPEED = 200.0
const JUMP_VELOCITY = -200

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 600


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("move_left", "move_right")
	velocity.x = direction * SPEED
	if direction !=0:
		sprite.flip_h = (direction == -1)
	
	# Attacks
	

	update_animations(direction)
	move_and_slide()
	print(velocity)

func update_animations(direction):
	if is_on_floor():
		if direction == 0:
			ap.play("idle")
		else:
			ap.play("run")
	else:
		if velocity.y < 0:
			ap.play("jump")
		elif velocity.y > 0:
			ap.play("fall")
		else:
			pass
