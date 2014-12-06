extends KinematicBody2D
var speed = 3.0

func _ready():
	set_fixed_process(true)
	pass
	
func rotate(pointTo):
	
	var mousePoint = Input.get_mouse_pos()
	set_rot(pointTo.angle_to_point(mousePoint))

func _fixed_process(delta):

	var move_left = Input.is_action_pressed("ui_left")
	var move_right = Input.is_action_pressed("ui_right")
	var move_up = Input.is_action_pressed("ui_up")
	var move_down = Input.is_action_pressed("ui_down")
	
	var dx = (move_left * -1) + (move_right * 1)
	var dy = (move_up * -1) + (move_down * 1)

	move(speed * Vector2(dx, dy))
	var pos1 = get_node("Position2D").get_pos()
	var pos2 = get_pos()
	pos2.x += pos1.x
	pos2.y += pos1.y
	rotate(pos2)
