extends CharacterBody2D

const SPEED = 400.0

func _process(_delta):
	
	# movement input
	var direction = Vector2.RIGHT
	velocity = direction * SPEED
	move_and_slide()

