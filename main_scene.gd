extends Node

var Hero = preload("hero.xml")
var Enemy = preload("enemy.xml")
var hero
var health_bar
var score_label
var viewbox = OS.get_video_mode_size()
var scores = 0

func _ready():
	hero = Hero.instance()
	hero.set_pos(Vector2(viewbox[0]/2, viewbox[1]/2))
	health_bar = get_node("health")
	score_label = get_node("score")
	add_child(hero)
	for i in range(1):
		var enemy = Enemy.instance()
		enemy.set_pos(Vector2(1000 * randf(), 1000 * randf()))
		enemy.setHero(hero)
		add_child(enemy)
	pass


func killEnemy(enemy):
	scores += enemy.getScores()
	print("+++++++++++++++++++++")
	print(viewbox[0])
	score_label.set_text("SCORE: " + str(scores))
	self.remove_and_delete_child(enemy)
	

func _on_Timer_timeout():
	var pos = Vector2(viewbox[0] * randf(), viewbox[1] * randf())
	var enemy = Enemy.instance()
	enemy.set_pos(pos)
	enemy.setHero(hero)
	add_child(enemy)
	print("Creating enemy in (", pos.x, ", ", pos.y,")")
	
func update_health():
	health_bar.set_value(hero.health)
	