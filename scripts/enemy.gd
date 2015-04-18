extends KinematicBody2D

var hero
var speed = 1

var health = 100
var cooldown = 1
var currentCooldown = 1
var scores = 500
var damage = 1
var damageRange = 50
var visibleRange = 300

func setHealth(hp):
	health = hp
	
	if (health <= 0):
		get_parent().killEnemy(self)
		
func setSpeed(sp):
	speed = sp

func damage(damage):
	setHealth(health - damage)

func _ready():
	      
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
	
	if hero.isDead():
		angle += 3.14

	if currentCooldown < cooldown:
		currentCooldown += delta

	var motion = speed * moveVect
	
	if hero.isDead():
		set_collide_with_kinematic_bodies(false)
		motion *= -1
	
	if (dist > damageRange && dist < visibleRange):
		set_rot(angle)
		move(motion)
	
		if (is_colliding()):
        	var n = get_collision_normal()
        	motion = n.slide(motion) 
        	move(motion)
	elif(dist < damageRange):
		if currentCooldown >= cooldown:
			hero.damage(damage)
			currentCooldown -= cooldown
			

	pass
	
func getScores():
	return scores
	
func pushout(motion):
	set_collide_with_kinematic_bodies(false)
	move(motion)
	set_collide_with_kinematic_bodies(true)
	