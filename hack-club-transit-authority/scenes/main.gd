extends Control
@onready var bus_app = $Apps/BusApp
@onready var system_app = $Apps/SystemManager


@onready var unlock_level = 0
@onready var total_money = 0

func _ready():
	$Taskbar/BusAppButton.pressed.connect(_bus_button_pressed)
	# $Taskbar/SystemButton.pressed.connect(_system_button_pressed)
	
	
	bus_app.state_changed.connect(_update_button_state)
	_update_button_state()

func _each_turn(unlock_level):
	$BusApp._each_turn(total_money)

func _update_button_state():
	$Taskbar/BusAppButton.disabled = bus_app.is_visible()
	$Taskbar/SystemButton.disabled = system_app.is_visible()


func _bus_button_pressed():
	bus_app.show()
	bus_app._taskbar_button_pressed()
	_update_button_state()
	
func _system_button_pressed():
	system_app.show()
	system_app._taskbar_button_pressed()
	_update_button_state()
