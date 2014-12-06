
extends Node2D

# member variables here, example	:
# var a=2
# var b="textvar"

var touching=0

func _input(ev):

	if (ev.type==InputEvent.MOUSE_MOTION):
		get_node("target").set_pos(ev.pos)

func _ready():
	set_process_input(true)
	pass
