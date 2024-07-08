extends CharacterBody2D

@export var speed = -60.0
var current_speed = 0.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var facing_right = false
var dead = false

var max_health = 2
var health
var hit = false
var can_attack = true

func _ready():
	health = max_health
	$AnimatedSprite2D.play("Run") 
	
func _process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if !$Node2D/RayCast2D.is_colliding() && is_on_floor():
		flip()
		
	if is_on_wall():
		flip()
		
	velocity.x = -speed
	move_and_slide()
	
func flip():
	facing_right = !facing_right
	
	scale.x = abs(scale.x) * -1
	if facing_right:
		speed = abs(speed)
	else:
		speed = abs(speed) * -1

func _on_area_2d_area_entered(area):
	if area.get_parent() is Player2D && !dead && can_attack:
		area.get_parent().take_damage(1)

func take_damage(damage_amount):
	if !dead:
		health -= damage_amount
		get_node("Healthbar").update_healthbar(health, max_health)
		$AnimatedSprite2D.play("Hit")
		await get_tree().create_timer(0.5).timeout
		$AnimatedSprite2D.play("Run") 
		
		if health <= 0:
			die()

func get_hit():
	hit = !hit
	
	if hit:
		current_speed = speed
		speed = 0
		can_attack = false
	else:
		speed = current_speed
		can_attack = true
		$AnimatedSprite2D.play("Run") 

func die():
	dead = true
	speed = 0
	queue_free()
