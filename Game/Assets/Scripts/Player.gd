extends KinematicBody2D
 
#variables
onready var corpus = $Sprite
onready var animation = $Sprite/anim
var looking_direction = true
var alt = 0
var acceleration = 400;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#Fuction that swtiches body direction
func switch_dir():
	looking_direction = !looking_direction
	corpus.flip_h = !corpus.flip_h

#Function thats controll every physics on body moviment
func _physics_process(delta):
	var direction = 0
	if Input.is_action_pressed("button_1"):
		direction = -1
	if Input.is_action_pressed("button_2"):
		direction = 1
    
	move_and_slide(Vector2(acceleration*direction, alt), Vector2(0, -1))
   
	var grounded = is_on_floor()
	alt += 50

	if is_on_floor() and Input.is_action_just_pressed("button_3"):
		alt = -1000

	if is_on_floor() and alt >= 5:
		alt = 5

	if alt > 1000:
		alt = 1000

	if (looking_direction and direction < 0) or (!looking_direction and direction > 0):
		switch_dir()

	if is_on_floor():
		if direction == 0:
			if animation.is_playing() and animation.current_animation == "idle":
				return
			animation.play("idle")
		else:
			if animation.is_playing() and animation.current_animation == "walk":
				return
			animation.play("walk")
	else:
		if animation.is_playing() and animation.current_animation == "jump":
				return
		animation.play("jump")
 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass
