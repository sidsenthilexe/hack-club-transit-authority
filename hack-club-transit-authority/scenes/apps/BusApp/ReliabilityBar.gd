extends TextureProgressBar

func _update_reliability(reliability):
	if (reliability == 0):
		value = 0
	elif (reliability == 10):
		value = 300
	elif (reliability > 0 && reliability < 10):
		value = ((29 * reliability) + 34)
