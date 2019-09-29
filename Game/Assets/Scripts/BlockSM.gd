extends Node2D

onready var sprite = get_node("Sprite")

enum {
	damage,
 	NoDamage,
 	Intangible,
 	Slow
}

var state
var anim

func _ready():
	state = NoDamage
	anim = "NoDamage"
	pass # Replace with function body.	


func _process(delta):

	ChangeState()
	match state:
		damage:
			pass
		NoDamage:
			pass
		Intangible:
			pass
		Slow:
			pass
			

func ChangeState():
	state = randi()%4
	if state == damage:
		anim =  "damage"
	elif state == NoDamage :
		anim = "NoDamage"
	elif state == Intangible:
		anim = "Intangible"
	elif state == Slow:
		anim = "Slow"
	sprite.play(anim)

func getState():
	return state
	
