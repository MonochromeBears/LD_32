func forward(point):
	point.y += 1
	return point
	
func backward(point):
	point.y -= 1
	return point
	
func left(point):
	point.x -= 1
	return point
	
func right(point): 
	point.x += 1
	return point