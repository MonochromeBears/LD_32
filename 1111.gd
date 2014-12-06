
extends Node2D

var bullet = preload("res://bullet.xml")

var spread = 20

func _input(ev):

	if ((ev.type == InputEvent.MOUSE_BUTTON) and (ev.button_index == 1)):
		var bi = bullet.instance()
		
		var pos = ev.pos

		var element = get_parent().get_name()
		var vector = (ev.pos - get_parent().getCurrentPoint()).normalized()

		bi.set_pos(get_parent().get_pos() + (spread + 5) * vector + Vector2(spread * randf() - spread / 2.0, spread * randf() - spread / 2.0))
		
		get_parent().get_parent().add_child(bi)

		
		bi.set_direct(vector)
		
func _ready():
	
	set_process_input(true)
	set_process(true)


