extends KinematicBody2D
func _ready():
	set_fixed_process(true)
	
func rotate():
	var point = get_pos()
	var mousePoint = Input.get_mouse_pos()
	
	set_rot(point.angle_to_point(mousePoint))

func _fixed_process(delta):
	var move_left = Input.is_action_pressed("ui_left")
	var move_right = Input.is_action_pressed("ui_right")
	var move_up = Input.is_action_pressed("ui_up")
	var move_down = Input.is_action_pressed("ui_down")
	var dx = (move_left * -1) + (move_right * 1)
	var dy = (move_up * -1) + (move_down * 1)
	move(Vector2(dx,dy))
	rotate()