extends Control

signal state_changed

func _ready():
	$TitleBar/Min.pressed.connect(_on_min_pressed)
	$TitleBar/Close.pressed.connect(_on_close_pressed)
	
func _on_min_pressed():
	hide()
	emit_signal("state_changed")

func _on_close_pressed():
	hide()
	emit_signal("state_changed")
	
func _taskbar_button_pressed():
	show()
	emit_signal("state_changed")
