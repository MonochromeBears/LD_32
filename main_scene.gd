extends Node

var Hero = preload("hero.xml")
var Enemy = preload("enemy.xml")
var Boss = preload("booboss.xml")
var deadBody = preload("DeadEnemy.xml")

var bossCounter = 0
var hero
var health_bar
var score_label
var viewbox = OS.get_video_mode_size()
var scores = 0
var gui

var death_sound

func _ready():
	randomize()
	get_node("Timer").start()

	health_bar = get_node("health")
	score_label = get_node("score")
	death_sound = get_node("death")
	gui = get_node("gui")
	
	createHero()
	
	for i in range(1):
		createEnemy()
	pass

func createHero():
	hero = Hero.instance()
	hero.set_pos(Vector2(viewbox[0] / 2, viewbox[1] / 2))
	add_child(hero)
	
func getEnemyHealth():
	return exp(scores / 100000.0 + 1) / 4
	
func getEnemySpeed():
	return scores / 100000.0 + 0.5
	
func createEnemy():
	var pos = Vector2(viewbox[0] * randf(), viewbox[1] * randf())
	var enemy = Enemy.instance()
	
	enemy.setHealth(getEnemyHealth())
	enemy.setSpeed(getEnemySpeed())
	enemy.setHero(hero)
	enemy.set_pos(pos)
	add_child(enemy)
	
func createBoss():
	var pos = Vector2(viewbox[0] * randf(), viewbox[1] * randf())
	var enemy = Boss.instance()

	enemy.setHealth(5 * getEnemyHealth())
	enemy.setSpeed(getEnemySpeed() * 1.2)
	enemy.setHero(hero)
	enemy.set_pos(pos)
	add_child(enemy)

func addScores(s):
	scores += s
	score_label.set_text("SCORE: " + str(scores))
	
	if scores > 10000 * (bossCounter + 1):
		bossCounter += 1
		createBoss()


func killEnemy(enemy):
	addScores(enemy.getScores())
	#self.remove_and_delete_child(enemy)
	var Decal = deadBody.instance()
	Decal.set_pos(enemy.get_pos())
	Decal.set_rot(enemy.get_rot())
	get_child("deadBodies").add_child(Decal)
	enemy.queue_free()
	death_sound.play()
	

func update_health():
	health_bar.set_value(hero.health * 5)
	if(hero.health <= 0):
		gui.set_pos(Vector2(0, 0))

func _on_Timer_timeout_():
	createEnemy()

func _on_backToMenu_pressed():
	get_node("/root/global").goto_scene("res://splash.xml")
	self.queue_free()
