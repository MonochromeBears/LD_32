extends KinematicBody2D

var _hero
var speed

func _ready():
	speed = 2.0 * randf()
	set_fixed_process(true)
	
func setHero(hero):
	_hero = hero
	
func _fixed_process(delta):
	var point = get_pos()
	var heroPoint = _hero.get_pos()
	var moveVect = (heroPoint - point).normalized()
	var angle = point.angle_to_point(heroPoint)
	set_rot(angle)

	move(speed * moveVect)

	pass
	