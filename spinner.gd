extends Spatial

func _physics_process(delta):
	rotation_degrees.y += 90 *delta
	rotation_degrees.y = wrapf(rotation_degrees.y,0,360)
