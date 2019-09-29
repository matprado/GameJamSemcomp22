extends Node2D


onready var sprite = get_node("Sprite")

enum {
	damage,
 	NoDamage,
 	Intangible,
 	Slow
}

var state =  NoDamage
var anim = "NoDamage"

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
