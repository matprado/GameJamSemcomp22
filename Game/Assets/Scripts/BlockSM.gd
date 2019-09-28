extends Node

onready var sprite = get_node("Sprite")

enum {
	damage,
	NoDamage,
	Intangible
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

func ChangeState():
	state = randi()%3
	if state == damage:
		anim =  "damage"
	elif state == NoDamage :
		anim = "NoDamage"
	elif state == Intangible:
		anim = "Intangible"
	sprite.play(anim)