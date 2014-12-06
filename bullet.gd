extends KinematicBody2D

# member variables here, example:
# var a=2
# var b="textvar"

var disabled=false
var direct = Vector2(0, 0)
var speed = 7

func disable():
	if (disabled):
		return
	disabled=true

func _ready():
	# Initalization here
	get_node("Timer").start()
	set_fixed_process(true)
	pass
	
func set_direct(d):
	direct = d

func _fixed_process(delta):
	move(speed * direct)
	
	if is_colliding():
		destroy()
	pass
	
func destroy():
	self.get_parent().remove_and_delete_child(self)
	


func _on_Timer_timeout():
	destroy()
