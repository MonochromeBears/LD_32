
extends Node

# member variables here, example:
# var a=2
# var b="textvar"





func _on_backToMenu_pressed():
	get_node("/root/global").goto_scene("res://splash.xml")
	self.queue_free()
