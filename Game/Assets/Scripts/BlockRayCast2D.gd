extends RayCast2D

enum {
	damage,
 	NoDamage,
 	Intangible,
 	Slow
}

onready var Block = get_parent()
var collide

func _ready():
	
	add_exception(Block)
	add_exception_rid(Block.get_child(0))
	add_exception_rid(Block.get_child(1))
	add_exception_rid(Block.get_child(2))
	add_exception_rid(Block.get_child(3))
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	force_raycast_update ()
	if is_colliding():
		collide = get_collider()
		colision()


func colision():
	if Block.getState() == damage:
		if collide.has_method("die"):
			collide.die()
	elif Block.getState() == Slow:
		if collide.has_method("slow"):
			collide.slow()