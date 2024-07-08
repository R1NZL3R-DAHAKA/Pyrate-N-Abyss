extends CharacterBody2D
class_name Player2D

@onready var ap = $AnimationPlayer
@onready var sprite = $Sprite2D

@export var attacking = false
@export var speed = 200.0
@export var hit =  false
@export var is_dead = false

const JUMP_VELOCITY = -200
const DOUBLE_JUMP_VELOCITY = -180  # Velocidad para el doble salto

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 600
var can_jump = true  # Bandera para permitir el salto
var has_double_jumped = false  # Bandera para rastrear si ya se realizó el doble salto
var _jump_count = 0 # Contador de saltos realizados

var max_health = 2
var health = 0
var can_take_damage = true

func _ready():
	health = max_health
	#GameManager.player = self

func _process(delta):
	if Input.is_action_just_pressed("attack") && !hit:
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
	
	if Input.is_action_just_pressed("move_right"):
		$AttackArea/CollisionShape2D.position.x = 29
	if Input.is_action_just_pressed("move_left"):
		$AttackArea/CollisionShape2D.position.x = -29
	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("move_left", "move_right")
	velocity.x = direction * speed
	if direction != 0:
		sprite.flip_h = (direction == -1)

	update_animations(direction)
	move_and_slide()
	print(velocity)
	
	if position.y >= 700:
		die()
	
func attack():
	var overlapping_object = $AttackArea.get_overlapping_areas()
	
	for area in overlapping_object:
		var parent = area.get_parent()
		print(parent.name)
		
		if area.get_parent().is_in_group("Enemies"):
			area.get_parent().take_damage(1)
	
	attacking = true
	ap.play("attack1")
	
func update_animations(direction):
	if !attacking && !hit:
		if direction != 0:
			ap.play("run")
		else:
			ap.play("idle")
		if velocity.y < 0:
			ap.play("jump")
		elif velocity.y > 0:
			ap.play("fall")	

func take_damage(damage_amount : int):
	if can_take_damage:
		iframes()
		hit = true
		attacking = false
		
		health = damage_amount
		
		if health <= 0:
			die()

func iframes():
	can_take_damage = false
	await get_tree().create_timer(1).timeout
	can_take_damage = true

func die():
	is_dead = true
	speed = 0
	queue_free()
	print("die")
	#GameManager.respawn_player()
