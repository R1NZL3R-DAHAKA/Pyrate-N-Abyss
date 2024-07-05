extends CharacterBody2D

var speed = -60.0
var current_speed = 0.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var facing_right = false
var dead = false
var max_health = 5
var health

func _ready():
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
	if area.get_parent("Player2D"):
		area.get_parent().die()

func die():
	queue_free()
