extends TextureProgressBar

func _update_efficiency(efficiency):
	if (efficiency == 0):
		value = 0
	elif (efficiency == 10):
		value = 300
	elif (efficiency > 0 && efficiency < 10):
		value = ((29 * efficiency) + 34)
	else :
		value = 0
