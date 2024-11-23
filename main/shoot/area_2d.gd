extends Area2D

var velocity = Vector2(500.0, 0.0)

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	position += velocity * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func set_direction(direction):
	# Ajusta a velocidade da bala com base na direção
	velocity.x *= direction  # -1 para esquerda, 1 para direita
