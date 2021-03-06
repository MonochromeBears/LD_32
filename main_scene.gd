extends Node

var Hero = preload("hero.xml")
var Enemy = preload("enemy.xml")
var Boss = preload("booboss.xml")
var deadBody = preload("DeadEnemy.xml")
var Loose = preload("loose.xml")

var enemyCounter = 0

var bossCounter = 0
var hero
var health_bar
var score_label
var shotgun_bar
var ultimate_bar
var viewbox = OS.get_video_mode_size()
var scores = 0

var death_sound

func _ready():
	randomize()
	get_node("Timer").start()

	health_bar = get_node("health")
	score_label = get_node("score")
	shotgun_bar = get_node("shotgun")
	ultimate_bar = get_node("ultimate")
	death_sound = get_node("death")
	
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
	var speed = scores / 100000.0 + 0.5
	get_node("Timer").set_wait_time(1 / (2 * speed))
	return scores / 100000.0 + 0.5

func newCord():
	var vert = (randf() > 0.5)
	var hori = (randf() > 0.5)
	var HoriPos = viewbox[0] * randf() * vert
	var VertPos = viewbox[1] * randf() * (!vert)
	if hori:
		if HoriPos:
			VertPos = viewbox[1]
		else:
			HoriPos = viewbox[0]
	return Vector2(HoriPos, VertPos )
func createEnemy():
	if(enemyCounter < 75):
		
		var pos = newCord()
		
		var enemy = Enemy.instance()
		
		enemy.setHealth(getEnemyHealth())
		enemy.setSpeed(getEnemySpeed())
		enemy.setHero(hero)
		enemy.set_pos(pos)
		add_child(enemy)
		enemyCounter += 1
		print("Creating enemy in (", pos.x, ", ", pos.y,")")
	
func createBoss():
	var pos = newCord()
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
	enemyCounter -= 1
	get_node("deadBodies").add_child(Decal)
	enemy.queue_free()
	death_sound.play()

func update_shotgun(s):
	shotgun_bar.set_value(100 - s * 100)
	
func update_ultimate(s):
	ultimate_bar.set_value(100 - s * 100)

func update_health():
	health_bar.set_value(hero.health * 5)
	if(hero.health <= 0):
		game_over()

func _on_backToMenu_pressed():
	get_node("/root/global").goto_scene("res://splash.xml")
	self.queue_free()
	
func game_over():
	var loose = Loose.instance()
	add_child(loose)
	loose.set_pos(Vector2(0, 0))

	loose.setScore(scores)
	


func _on_Timer_timeout():
	createEnemy()
