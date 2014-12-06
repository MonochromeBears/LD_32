
extends Node

# member variables here, example:
# var a=2
# var b="textvar"

var world = preload("res://main_scene.xml");
var worldInstance

func _ready():
	worldInstance = world.instance()

func _on_TextureButton_pressed():
	get_node("/root/global").goto_scene("res://main_scene.xml")
	self.queue_free()