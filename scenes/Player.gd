extends KinematicBody2D

const GRAVITY: int = 1000
const MAXHSPEED: int = 133
const JUMPSPEED: int = 360
const HORIZONTALAC: int = 2200
const JUMPTERMULT: int = 4
var velocity: Vector2 = Vector2.ZERO


func _process(delta):
	var move_vector: Vector2 = Vector2.ZERO
	move_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	move_vector.y = -1 if Input.is_action_just_pressed("jump") else 0
	
	velocity.x += move_vector.x * HORIZONTALAC * delta
	if move_vector.x == 0:
		velocity.x = lerp(0, velocity.x, pow(2, -55 * delta))
		
	velocity.x = clamp(velocity.x, -MAXHSPEED, MAXHSPEED)
	
	if move_vector.y < 0 and is_on_floor():
		velocity.y = move_vector.y * JUMPSPEED
		
	if velocity.y < 0 and !Input.is_action_pressed("jump"):
		velocity.y += GRAVITY * JUMPTERMULT * delta
	else:
		velocity.y += GRAVITY * delta
		
	velocity = move_and_slide(velocity, Vector2.UP)
