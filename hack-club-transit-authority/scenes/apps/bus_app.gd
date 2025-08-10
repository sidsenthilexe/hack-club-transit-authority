extends Control

var is_maximized := false
var small_size := Vector2(500, 350)
var large_size := Vector2(1280, 770)

signal closed
signal minimized

func _ready():
	$TitleBar/Close.pressed.connect(_on_close_pressed)
	$TitleBar/Max.pressed.connect(_on_max_pressed)
	$TitleBar/Min.pressed.connect(_on_min_pressed)

func _on_close_pressed():
	hide()
	emit_signal("closed")
	
func _on_max_pressed():
	is_maximized = !is_maximized
	if (is_maximized):
		size = large_size
		$WindowBG.texture = preload("res://art/final/app/template_large.png")
	else:
		size = small_size
		$WindowBG.texture = preload("res://art/final/app/template_small.png")
	
func _on_min_pressed():
	hide()
	emit_signal("minimized")
