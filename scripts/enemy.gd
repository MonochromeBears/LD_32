extends KinematicBody2D

var _hero

func _ready():
	set_fixed_process(true)
	
func setHero(hero):
	_hero = hero
	
func _fixed_process(delta):
	rotate()
	#move()
	pass

func rotate():
	var point = get_pos()
	var heroPoint = _hero.get_pos()
	
	var angle = point.angle_to_point(heroPoint)
	set_rot(angle)
	pass
