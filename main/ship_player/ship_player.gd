extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var shoot_interval = 0.3  # Intervalo entre disparos (em segundos)
var time_since_last_shot = 0.0  # Tempo decorrido desde o último disparo
func _init():
	print(ProjectSettings.get_setting("physics/2d/default_gravity"))


func _physics_process(delta):
	time_since_last_shot +=delta
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction_y = Input.get_axis("ui_up", "ui_down")
	if direction_y:
		velocity.y = direction_y * SPEED
	else:
		velocity.y = move_toward(velocity.x, 0, SPEED)
	var direction_x = Input.get_axis("ui_left", "ui_right")
	if direction_x:
		velocity.x = direction_x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		# Garantir que a nave fique dentro dos limites da tela considerando o tamanho da colisão
	var screen_size = get_viewport_rect().size
	var collision_bounds = $ShipPlayerCollision.shape.extents.x
	
	if Input.is_action_pressed("ui_accept"):
		if time_since_last_shot > shoot_interval:
			time_since_last_shot = 0;
			var bullet = preload("res://main/shoot/shoot_scene.tscn").instantiate()
			bullet.get_node("Area2D").set_direction(-1 if $ShipPlayerShape/ShipPlayerSprite.flip_h else 1)  # Define a direção baseada no flip_h
			get_parent().add_child(bullet)
			bullet.position = position
	
# Limita a posição X levando em conta o tamanho da colisão
	position.x = clamp(position.x, collision_bounds, screen_size.x - collision_bounds)
	position.y = clamp(position.y, collision_bounds, screen_size.y - collision_bounds)
	move_and_slide()
