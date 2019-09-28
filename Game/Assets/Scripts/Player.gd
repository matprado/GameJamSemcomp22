extends KinematicBody2D
 
# Declare member variables here. Examples:
onready var corpus = $Sprite
onready var animation = $Sprite/anim
var looking_direction = true
var alt = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	var direction = 0
	if Input.is_action_pressed("button_1"):
		direction -= 1
	if Input.is_action_pressed("button_2"):
		direction += 1
    
	move_and_slide(Vector2(direction * 500, alt), Vector2(0, -1))
   
	var grounded = is_on_floor()
	alt += 500
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		alt = -1000
	if is_on_floor() and alt >= 10:
		alt = 10
	if alt > 1000:
		alt = 1000

	if looking_direction and direction < 0:
		flip()
	if !looking_direction and direction > 0:
		 flip()
   
	if is_on_floor():
		if direction == 0:
			play_anim("idle")
		else:
			play_anim("walk")
	else:
		play_anim("jump")
 

func flip():
	looking_direction = !looking_direction
	corpus.flip_h = !corpus.flip_h
 
func play_anim(anim_name):
	if animation.is_playing() and animation.current_animation == anim_name:
		return
	animation.play(anim_name)




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass
