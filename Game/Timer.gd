extends Node2D

onready var label = get_child(0)
onready var timer = get_child(1)
signal endTime
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var text = timer.time_left
	label.set_text("Time:" + str(int(text)))

func _on_Timer_timeout():
	emit_signal("endTime")
	pass # Replace with function body.
