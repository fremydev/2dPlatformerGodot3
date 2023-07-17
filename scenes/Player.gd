extends KinematicBody2D

const GRAVITY: int = 300
const MAXHSPEED: int = 100
const JUMPSPEED: int = 100
var velocity: Vector2 = Vector2.ZERO


func _process(delta):
	var move_vector: Vector2 = Vector2.ZERO
	move_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	move_vector.y = -1 if Input.is_action_just_pressed("jump") else 0
	
	velocity.x = move_vector.x * MAXHSPEED
	
	if move_vector.y < 0 and is_on_floor():
		velocity.y = move_vector.y * JUMPSPEED
	velocity.y += GRAVITY * delta
	velocity = move_and_slide(velocity, Vector2.UP)
