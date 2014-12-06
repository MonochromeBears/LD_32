extends KinematicBody2D
var speed = 3.0

func _ready():
	set_fixed_process(true)
	pass
	
func getSpeed():
	return speed
	
func getAngle():
	var pos1 = get_node("Position2D").get_pos()
	var pos2 = get_pos()
	var pointTo = pos1 + pos2
	var mousePoint = Input.get_mouse_pos()

	return pointTo.angle_to_point(mousePoint)
	
func rotate():
	set_rot(getAngle())

func _fixed_process(delta):

	var move_left = Input.is_action_pressed("ui_left")
	var move_right = Input.is_action_pressed("ui_right")
	var move_up = Input.is_action_pressed("ui_up")
	var move_down = Input.is_action_pressed("ui_down")
	
	var dx = (move_left * -1) + (move_right * 1)
	var dy = (move_up * -1) + (move_down * 1)

	move(speed * Vector2(dx, dy))

	rotate()
