extends CharacterBody2D

signal laser(pos, direction)
signal grenade(pos, direction)

var can_laser: bool = true
var can_grenade: bool = true

@export var speed = 500.0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	# movement input
	var direction: Vector2 = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()
	
	# rotate
	look_at(get_global_mouse_position())
	
	var player_direction = (get_global_mouse_position() - position).normalized()
	# laser shooting input
	if Input.is_action_pressed("primary action") and can_laser:
		$LaserStartPositions/GPUParticles2D.emitting = true
		# randomly selected a marker 2D for the laser
		var laser_markers = $LaserStartPositions.get_children()
		var selected_laser = laser_markers[randi() % laser_markers.size()]

		# emit the position selected
		laser.emit(selected_laser.global_position, player_direction)
		can_laser = false
		$PrimaryActionTimer.start()
		
	# grenade shooting input
	if Input.is_action_pressed("secondary action") and can_grenade:
		grenade.emit($LaserStartPositions.get_children()[0].global_position, player_direction)
		can_grenade = false
		$SecondaryActionTimer.start()

func _on_timer_primary_action_timeout():
	can_laser = true # Replace with function body.

func _on_timer_secondary_action_timeout():
	can_grenade = true # Replace with function body.
