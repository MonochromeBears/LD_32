extends Node

var Hero = preload("hero.xml")
var Enemy = preload("enemy.xml")

func _ready():
	var hero = Hero.instance()
	var enemy = Enemy.instance()
	hero.set_pos(Vector2(50, 50))
	enemy.set_pos(Vector2(150, 150))
	
	enemy.setHero(hero)
	add_child(hero)
	add_child(enemy)
	pass


