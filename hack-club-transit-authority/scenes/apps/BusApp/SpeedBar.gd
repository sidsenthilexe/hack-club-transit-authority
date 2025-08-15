extends TextureProgressBar

func _update_speed(speed):
	if (speed == 0):
		value = 0
	elif (speed == 10):
		value = 300
	elif (speed > 0 && speed < 10):
		value = ((29*speed) + 34)
	else:
		value = 0
