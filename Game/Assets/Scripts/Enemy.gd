extends Node2D

const GRAVITY = 10
const DOG_SPEED = 25
const DOG_RUN_SPEED = 200
const GOLEM_SPEED = 30
const COLLIDE_WALL = Vector2(1, 0)

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
var collided

var bark
var golem_sound

signal hit

enum {
	DOG,
	GOLEM
}

var is_running = false
var state

#signal hit;

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	change_state()
	$FlipTimer.wait_time = rand_range(1.0, 5.0)
	$WalkRunTimer.wait_time = rand_range(1.0, 5.0)
	$KinematicBody2D/AnimatedSprite.set_flip_h(true)
	#$KinematicBody2D/AnimatedSprite.play("DogWalk");
	
	pass # Replace with function body.

func _physics_process(delta):
	
	match state:
		DOG:
			if(is_running):	
				velocity.x = DOG_RUN_SPEED * direction
			else:
				velocity.x = DOG_SPEED * direction
			pass	
		GOLEM:
			velocity.x = GOLEM_SPEED * direction
			pass
			
	velocity.y += GRAVITY
	velocity = $KinematicBody2D.move_and_slide(velocity)
	
	for i in range($KinematicBody2D.get_slide_count()):
		collided = $KinematicBody2D.get_slide_collision(i).get_collider()
		if(collided && collided.get_class() == "KinematicBody2D"):
			for j in collided.get_groups():
				if(j == "Player"):
					emit_signal("hit")
					
				
	pass

func change_state():
	
	state = randi() % 2
	
	match state:  
		DOG:
			state = GOLEM
			change_to_golem()
			pass
		GOLEM:
			state = DOG
			change_to_dog()
			pass

func change_to_golem():
	$KinematicBody2D/CollisionShape2D.position.x = GOLEM_POSITION_X
	$KinematicBody2D/CollisionShape2D.position.y = GOLEM_POSITION_Y
	$KinematicBody2D/CollisionShape2D.scale.x = GOLEM_SCALE_X
	$KinematicBody2D/CollisionShape2D.scale.y = GOLEM_SCALE_Y
	$RunAudio.stop()
	$KinematicBody2D/AnimatedSprite.play("GolemWalk")
	randomize()
	golem_sound = randi() % 2
	if(golem_sound == 0):
		$GolemAudio.play()	
	pass

func change_to_dog():
	$GolemAudio.stop()
	$KinematicBody2D/CollisionShape2D.position.x = DOG_POSITION_X
	$KinematicBody2D/CollisionShape2D.position.y = DOG_POSITION_Y
	$KinematicBody2D/CollisionShape2D.scale.x = DOG_SCALE_X
	$KinematicBody2D/CollisionShape2D.scale.y = DOG_SCALE_Y
	if(is_running):
		$KinematicBody2D/AnimatedSprite.play("DogRun")
		randomize()
		bark = randi() % 2
		if(bark == 0):
			$RunAudio.play()		
	else:
		$KinematicBody2D/AnimatedSprite.play("DogWalk")
	pass
	
func _on_Timer_timeout():
	direction *= -1
	if(direction > 0):
		$KinematicBody2D/AnimatedSprite.set_flip_h(true)
	else:
		$KinematicBody2D/AnimatedSprite.set_flip_h(false)
	
	pass # Replace with function body.


func _on_WalkRunTimer_timeout():
	if(state == DOG):
		$GolemAudio.stop()
		if(is_running):
			is_running = false
			$KinematicBody2D/AnimatedSprite.play("DogWalk")
			$RunAudio.stop()
		else:
			is_running = true
			$KinematicBody2D/AnimatedSprite.play("DogRun");	
			randomize()
			bark = randi() % 2
			if(bark == 0):
				$RunAudio.play()	
	pass # Replace with function body.