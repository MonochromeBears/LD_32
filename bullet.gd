extends Area2D

# member variables here, example:
# var a=2
# var b="textvar"

var disabled=false
var direct = Vector2(0, 0)
var speed = 2

var pulse = 0.1
var maxScale = 3

var damage = 1
var cooldown = 2
var currentCooldown

var enemy = preload("res://scripts/enemy.gd")
var boss = preload("res://scripts/booboss.gd")

func disable():
	if (disabled):
		return
	disabled=true

func _ready():
	# Initalization here
	set_fixed_process(true)
	pass
	
func set_direct(d):
	direct = d

func isEnemy(obj):
	return (obj extends enemy) or (obj extends boss)


func _fixed_process(delta):
	if (get_scale().x > maxScale):
		pulse = pulse * -1
	if (get_scale().x < 0.2):
		destroy()
	set_scale(Vector2(get_scale().x + pulse, get_scale().y + pulse))

func destroy():
	self.queue_free()
	#self.get_parent().remove_and_delete_child(self)
	


func _on_bullet_body_enter( body ):
	if isEnemy(body):
		if(randf()<0.2):
			body.damage(damage*999)
		#destroy()
