extends Camera2D
## Cámara principal para escenarios.
##
## Mueve la cámara para seguir al personaje principal (usando un movimiento suavizado)
## Movimiento de cámara: https://docs.google.com/document/d/1kHbZN0nhy9GFL3zyO4tTZK4lqELZ3YDkbpxj6XVEkq8/edit?usp=sharing


# Referencia al personaje principal
@export var character: CharacterBody2D

# Límites del mapa


# Función de inicialización
func _ready():
	# Si no hay personaje, deshabilitamos _physics_process y terminamos la función
	if not character:
		set_physics_process(false)
		return
	# Seteamos posición inicial de la cámara
	position = character.position

# Función de ejecución de físicas
func _physics_process(delta):
	# Generamos posiciones "interpoladas" (entre la posición de la cámara y el personaje)
	# para realizar el movimiento de la cámara
	# Validamos si el personaje está vivo y no murió
	if not character:
		# Si el personaje está muerto dejamos de seguirlo
		return
	var charpos = character.position
	var new_pos = position.lerp(charpos, delta * 2.0)
	# Ajustamos los valores a números enteros, para evitar mover la cámara demasiadas veces
	new_pos.x = int(new_pos.x)
	new_pos.y = int(new_pos.y)
	
	# Limitar la posición de la cámara dentro de los límites del mapa
	new_pos.x = clamp(new_pos.x, limit_left, limit_right)
	new_pos.y = clamp(new_pos.y, limit_top, limit_bottom)
	
	# Seteamos la nueva posición de la cámara
	position = new_pos
