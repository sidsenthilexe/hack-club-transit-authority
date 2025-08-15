extends TextureProgressBar

func _update_level(level):
	if (level == 0) :
		value = 0
	elif (level == 10):
		value = 100
	elif (level > 0 && level < 10):
		value = ((29*level) + 34)
	else :
		value = 0
