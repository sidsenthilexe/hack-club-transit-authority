extends TextureProgressBar

func _update_capacity(capacity):
	if (capacity == 0):
		value = 0
	elif (capacity == 10):
		value = 300
	elif (capacity > 0 && capacity < 10):
		value = ((29*capacity) + 34)
	else :
		value = 0
