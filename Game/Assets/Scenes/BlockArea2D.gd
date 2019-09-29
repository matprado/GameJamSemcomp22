extends Area2D

enum {
	damage,
 	NoDamage,
 	Intangible,
 	Slow
}

onready var Block = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_BlockArea_body_entered(body):
	if Block.getState() == damage:
		if body.has_method("die"):
			body.die()
			return
	elif Block.getState() == Slow:
		if body.has_method("slow"):
			body.slow()
			return