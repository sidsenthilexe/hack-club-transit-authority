extends TextureProgressBar

func _update_frequency(frequency):
	if (frequency == 0):
		value = 0
	elif (frequency == 10):
		value = 300
	elif (frequency > 0 && frequency < 10):
		value = ((29*frequency)+34)
	else :
		value = 0
