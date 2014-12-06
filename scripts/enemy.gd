extends KinematicBody2D

var hero
var speed

func _ready():
	speed = 2.0 * randf()
	set_fixed_process(true)
	
func setHero(h):
	hero = h
	
func _fixed_process(delta):
	var point = get_pos()
	var heroPoint = hero.get_pos() + hero.getLastStep()
	var moveVect = (heroPoint - point).normalized()
	var angle = point.angle_to_point(heroPoint)
	set_rot(angle)

	move(speed * moveVect)

	pass
	