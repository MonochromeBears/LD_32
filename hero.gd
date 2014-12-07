extends KinematicBody2D

var viewbox = OS.get_video_mode_size()

var explosion = preload("explosion.xml")

var enemy = preload("res://scripts/enemy.gd")
var boss = preload("res://scripts/booboss.gd")

var speed = 3.0
var superstrikeRange = 75
var lastStep = Vector2(0, 0)

var superstrikeCooldown = 5
var superstrikeCurrentCooldown = superstrikeCooldown


var dead = false
var superstrikeReady = true

var health = 20

func damage(dmg):
	setHealth(health - dmg)
	pass
	
func isDead():
	return dead
	
func setHealth(hp):
	health = hp
	print(health)
	get_parent().update_health()
	if hp <= 0:
		destroy()
		
func _ready():
	get_node("start_pos 2").setRoot(get_parent())
	set_fixed_process(true)
	pass
	
func getSpeed():
	return speed
	
func getAngle():
	var mousePoint = Input.get_mouse_pos()
	var pointTo = getCurrentPoint()

	return pointTo.angle_to_point(mousePoint)
	
func rotate():
	set_rot(getAngle())
	
func getCurrentPoint():

	var pos2 = get_pos()

	return pos2

func getLastStep():
	return lastStep

func _fixed_process(delta):
	if dead:
		return
		
	superstrikeCurrentCooldown += delta
	
	get_parent().update_ultimate(superstrikeCurrentCooldown / superstrikeCooldown)
		
	var move_left = Input.is_action_pressed("ui_left")
	var move_right = Input.is_action_pressed("ui_right")
	var move_up = Input.is_action_pressed("ui_up")
	var move_down = Input.is_action_pressed("ui_down")
	
	var superstrike = Input.is_action_pressed("ui_superstrike")
	
	var dx = (move_left * -1) + (move_right * 1)
	var dy = (move_up * -1) + (move_down * 1)

	var pos = get_pos()

	lastStep = speed * Vector2(dx, dy)
	var nextPos = pos + lastStep
	
	if Rect2(0, 40, viewbox[0], viewbox[1]).has_point(nextPos):
		move(lastStep)
	
	if superstrike and (superstrikeCurrentCooldown >= superstrikeCooldown):
		superstrike()

	rotate()

func destroy():
	dead = true
	set_collide_with_kinematic_bodies(false)
	pass
	
func isEnemy(obj):
	return (obj extends enemy) or (obj extends boss)
	
func superstrike():
	superstrikeCurrentCooldown = 0
	get_node("Wave").set_emitting(true)
	get_node("Timer").start()
	
	pass
	

func _on_Timer_timeout():
	get_node("Wave").set_emitting(false)
	for enemy in get_parent().get_children():
		if isEnemy(enemy):
			var pushVector = (enemy.get_pos() - getCurrentPoint()).normalized()
			
			enemy.pushout(superstrikeRange * pushVector)
	pass # replace with function body
