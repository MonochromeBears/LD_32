
extends TileMap

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	for i in range(-100, 100):
		for j in range(-100, 100):
			var tileId = 0
			if i == -80:
				if j == -80:
					tileId = 7
				elif j == 80:
					tileId = 5
				else:
					tileId = 3
			elif i == 80:
				if j == -80:
					tileId = 6
				elif j == 80:
					tileId = 8
				else:
					tileId = 2
			elif j == -80:
				tileId = 1
			elif j == 80:
				tileId = 4
			set_cell(i, j, tileId)
	# Initialization here
	pass


