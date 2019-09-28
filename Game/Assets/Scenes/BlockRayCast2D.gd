extends RayCast2D

enum {
	damage,
 	NoDamage,
 	Intangible,
 	Slow
}

onready var Block = get_parent()
var collide

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_colliding():
		collide = get_collider()
		collide = collide.get_parent()
		colision()


func colision():
	if Block.getState() == damage:
		if collide.has_method("die"):
			collide.die()
	elif Block.getState() == Slow:
		if collide.has_method("slow"):
			collide.slow()