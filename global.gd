
extends Node
	
func goto_scene(scene):
	var s = ResourceLoader.load(scene)
	get_parent().add_child(s.instance())
