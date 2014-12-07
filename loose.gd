
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Initalization here
	pass

func setScore(score):
	get_node("score").set_text("SCORE: " + str(score))

func _on_backToMenu_pressed():
	get_node("/root/global").goto_scene("res://splash.xml")
	get_parent().queue_free()
	self.queue_free()
