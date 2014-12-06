
extends Node2D

var bullet = preload("res://bullet.xml")

func _input(ev):

	if (ev.type==InputEvent.MOUSE_BUTTON):
		var bi = bullet.instance()
		
		var pos = ev.pos

		var element = get_parent().get_name()
		var vector = ev.pos-get_parent().get_pos()

		bi.set_pos(get_parent().get_pos() + 5 * vector.normalized())
		
		get_parent().get_parent().add_child(bi)

		
		bi.set_direct(vector.normalized())
		
func _ready():
	
	set_process_input(true)
	set_process(true)


