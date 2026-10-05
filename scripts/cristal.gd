extends StaticBody2D


func _process(delta):

	if Input.is_action_just_pressed("Rotate"):
		rotate(deg_to_rad(45))
