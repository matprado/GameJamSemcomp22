extends StaticBody2D

enum {
	damage,
 	NoDamage,
 	Intangible,
 	Slow
}

onready var shape = get_child(0)
onready var node = get_parent()

func _process(delta):
	if node.getState() == Intangible:
		shape.set_disabled(true)
	else:
		shape.set_disabled(false)