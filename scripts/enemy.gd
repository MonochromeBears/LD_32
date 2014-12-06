extends KinematicBody2D

var hero
var speed

var health = 100

func setHealth(hp):
	health = hp
	print(hp)
	
	if (health <= 0):
		destroy()

func damage(damage):
	setHealth(health - damage)

func _ready():
	speed = 2.0 * randf()
	set_fixed_process(true)
	
func setHero(h):
	hero = h
	
func _fixed_process(delta):
	var point = get_pos()
	var lastStep = hero.getLastStep();
	var heroPoint = hero.get_pos()

	var dist = point.distance_to(heroPoint)

	var moveVect = (heroPoint - point).normalized()
	var angle = point.angle_to_point(heroPoint)
	set_rot(angle)

	var motion = speed * moveVect
	
	if dist > 20:
		move(motion)
	
		if (is_colliding()):
        	var n = get_collision_normal()
        	motion = n.slide(motion) 
        	move(motion)

	pass

func destroy():
	self.get_parent().remove_and_delete_child(self)