extends Node

var Hero = preload("hero.xml")
var Enemy = preload("enemy.xml")

func _ready():
	var hero = Hero.instance()
	hero.set_pos(Vector2(500, 500))
	add_child(hero)
	for i in range(10):
		var enemy = Enemy.instance()
		enemy.set_pos(Vector2(1000 * randf(), 1000 * randf()))
		enemy.setHero(hero)
		add_child(enemy)
	pass


