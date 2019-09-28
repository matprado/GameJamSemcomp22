extends Node2D

const GRAVITY = 10
const SPEED = 30
const FLOOR = Vector2(0, -1)

var velocity = Vector2(50, 0)
var direction = 1
#var collision;

#signal hit;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):	
	velocity.x = SPEED * direction
	velocity.y += GRAVITY	
	velocity = $KinematicBody2D.move_and_slide(velocity, FLOOR)	
	pass

func _on_Timer_timeout():
	direction *= -1
	if(direction > 0):
		$KinematicBody2D/Sprite.set_flip_h(false)
	else:
		$KinematicBody2D/Sprite.set_flip_h(true)
	
	pass # Replace with function body.
