
extends Node2D

var bullet = preload("res://bullet.xml")

func _input(ev):

	if (ev.type==InputEvent.MOUSE_BUTTON):
		var bi = bullet.instance()
		
		var pos = ev.pos

		bi.set_pos(get_parent().get_pos())
		
		get_parent().get_parent().add_child(bi)

		var element = get_parent().get_name()
		var vector = ev.pos-get_parent().get_pos()
		print(vector.normalized())
		
		bi.set_linear_velocity(vector.normalized()*100)
		
func _ready():
	
	set_process_input(true)
	set_process(true)


