extends RigidBody2D

const SPEED = 750

func explode():
	$AnimationPlayer.play("Explosion")
