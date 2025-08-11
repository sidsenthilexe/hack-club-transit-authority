extends Control
@onready var bus_app = $BusApp

var unlock_level = 0


func _ready():
	$Taskbar/BusAppButton.pressed.connect(_bus_button_pressed)
	bus_app.state_changed.connect(_update_button_state)
	_update_button_state()

func _update_button_state():
	$Taskbar/BusAppButton.disabled = bus_app.is_visible()

func _bus_button_pressed():
	bus_app.show()
	bus_app._taskbar_button_pressed()
	_update_button_state()
