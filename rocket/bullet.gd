extends KinematicBody2D

# member variables here, example:
# var a=2
# var b="textvar"

var disabled=false
var direct = Vector2(0, 0)
var speed = 7
var health = 100
var damage = 3

var enemy = preload("res://scripts/enemy.gd")

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
		var damaged = get_collider()
		if damaged extends enemy:
			get_collider().damage(damage)
			destroy()
	pass
	
func destroy():
	self.queue_free()
	#self.get_parent().remove_and_delete_child(self)
	


func _on_Timer_timeout():
	destroy()
