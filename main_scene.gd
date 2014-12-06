extends Node

var Hero = preload("hero.xml")
var Enemy = preload("enemy.xml")
var hero

var scores = 0

func _ready():
	hero = Hero.instance()
	hero.set_pos(Vector2(500, 500))
	add_child(hero)
	for i in range(1):
		var enemy = Enemy.instance()
		enemy.set_pos(Vector2(1000 * randf(), 1000 * randf()))
		enemy.setHero(hero)
		add_child(enemy)
	pass


func killEnemy(enemy):
	scores += enemy.getScores()
	print("Scores: ", scores)
	self.remove_and_delete_child(enemy)
	

func _on_Timer_timeout():
	var enemy = Enemy.instance()
	enemy.set_pos(Vector2(1000 * randf(), 1000 * randf()))
	enemy.setHero(hero)
	add_child(enemy)
	pass # replace with function body
