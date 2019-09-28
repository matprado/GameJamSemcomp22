extends Node

onready var sprite = get_node("Sprite")

enum {
<<<<<<< HEAD
 damage,
 NoDamage,
 Intangible
=======
	damage,
	NoDamage,
	Intangible
>>>>>>> 6fdc375c240ba3e138241b592092c3d958f4f2e3
}

var state =  NoDamage
var anim = "NoDamage"

func _process(delta):
<<<<<<< HEAD
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
=======
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
>>>>>>> 6fdc375c240ba3e138241b592092c3d958f4f2e3
