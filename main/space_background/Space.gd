extends ParallaxLayer

var motion = Vector2(-50, 0)  # Motion of the scroll
var speed = -50  # Speed of the scroll

func _ready():
	pass

func _process(delta):
	speed -= 5
	set_motion_offset(motion + Vector2(speed, 0))
