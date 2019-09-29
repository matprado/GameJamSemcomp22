extends KinematicBody2D
 
#variables
onready var corpus = $Sprite
onready var animation = $Sprite/anim
enum {
	damage,
 	NoDamage,
 	Intangible,
 	Slow
}
var looking_direction = true
var alt = 0
var acceleration = 400
var slowed
var up
var down
var left
var right

signal trade_blocks
signal trade_enemies

# Called when the node enters the scene tree for the first time.
func _ready():
	$Music.play()
	slowed = false
	var verify = true
	randomize_buttons()
	pass # Replace with function body.

#Fuction that swtiches body direction
func switch_dir():
	looking_direction = !looking_direction
	corpus.flip_h = !corpus.flip_h

#Function thats controll every physics on body moviment
func _physics_process(delta):
	var direction = 0

	if Input.is_action_pressed(left):
		direction = -1
	if Input.is_action_pressed(right):
		direction = 1
	
	if Input.is_action_pressed(down):
		emit_signal("trade_blocks")
		emit_signal("trade_enemies")
		randomize_buttons()
		showWarning()
	
	move_and_slide(Vector2(acceleration*direction, alt), Vector2(0, -1))
   
	alt += 50
	
	
	if is_on_floor() and Input.is_action_just_pressed(up):
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
			$AudioTimer.start()	
			animation.play("idle")
		else:
			$BreathAudio.stop()
			if animation.is_playing() and animation.current_animation == "walk":
				return
			animation.play("walk")
	else:
		$BreathAudio.stop()
		if animation.is_playing() and animation.current_animation == "jump":
				return
		$JumpAudio.play()		
		animation.play("jump")
 

func randomize_buttons():
	var sample = [1,2,3,4]
	var rn = []
	var x
	for i in range(4):
		x = randi()%sample.size()
		rn.append(sample[x])
		sample.remove(x)
	up = "button_" + str(rn.pop_front())
	down = "button_" + str(rn.pop_front())
	left = "button_" + str(rn.pop_front())
	right = "button_" + str(rn.pop_front())

func showWarning():
	$warning.visible = true
	$WarningTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_Timer_timeout():
	$warning.visible = false;
	pass # Replace with function body.

func _on_Area2D_body_entered(body):
	if(body == self):
		Global.goto_scene("res://Assets/Scenes/MenuInicial.tscn")
	pass # Replace with function body.


func die():
	Global.goto_scene("res://Assets/Scenes/MenuInicial.tscn")
	pass

func slow():	
	if(!slowed):
		acceleration /= 2
		slowed = true
		
	$SlowTimer.start()
	pass


func _on_Enemy_hit():
	Global.goto_scene("res://Assets/Scenes/MenuInicial.tscn")
	pass # Replace with function body.


func _on_SlowTimer_timeout():
	if(slowed):
		acceleration *= 2
	slowed = false
	pass # Replace with function body.


func _on_AudioTimer_timeout():
	$BreathAudio.play()
	pass # Replace with function body.


func _on_FinalFlag_win():
	_on_Enemy_hit()
	pass # Replace with function body.


func _on_Timer_endTime():
	die()
	pass # Replace with function body.
