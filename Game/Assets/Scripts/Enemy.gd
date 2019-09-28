extends Node2D

const GRAVITY = 10
const SPEED = 25
const RUN_SPEED = 200
const FLOOR = Vector2(0, -1)
const DOG_POSITION_X = -1.1138
const DOG_POSITION_Y = 2.923
const DOG_SCALE_X = 1
const DOG_SCALE_Y = 1
const GOLEM_POSITION_X = 9.055
const GOLEM_POSITION_Y = 0.606
const GOLEM_SCALE_X = 0.65
const GOLEM_SCALE_Y = 1.2


var velocity = Vector2(1, 0)
var direction = 1

var is_running = false

#signal hit;

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$FlipTimer.wait_time = rand_range(1.0, 5.0)
	$WalkRunTimer.wait_time = rand_range(1.0, 5.0)
	$KinematicBody2D/AnimatedSprite.set_flip_h(true)
	$KinematicBody2D/AnimatedSprite.play("DogWalk");
	pass # Replace with function body.

func _physics_process(delta):
	if(is_running):	
		velocity.x = RUN_SPEED * direction
	else:
		velocity.x = SPEED * direction	
	velocity.y += GRAVITY	
	velocity = $KinematicBody2D.move_and_slide(velocity, FLOOR)	
	pass

func _on_Timer_timeout():
	direction *= -1
	if(direction > 0):
		$KinematicBody2D/AnimatedSprite.set_flip_h(true)
	else:
		$KinematicBody2D/AnimatedSprite.set_flip_h(false)
	
	pass # Replace with function body.


func _on_WalkRunTimer_timeout():
	if(is_running):
		is_running = false
		$KinematicBody2D/AnimatedSprite.play("DogWalk");
	else:
		is_running = true
		$KinematicBody2D/AnimatedSprite.play("DogRun");	
	pass # Replace with function body.