extends Control
@onready var bus_app = $Apps/BusApp
@onready var system_app = $Apps/SystemManager
@onready var map_app = $Apps/MapApp


@onready var unlock_level = 0
@onready var total_money = 0

func _ready():
	$Taskbar/BusAppButton.pressed.connect(_bus_button_pressed)
	$Taskbar/SystemButton.pressed.connect(_system_button_pressed)
	$Taskbar/MapAppButton.pressed.connect(_map_button_pressed)
	bus_app.stateChanged.connect(_update_button_state)
	map_app.state_changed.connect(_update_button_state)
	system_app.state_changed.connect(_update_button_state)
	bus_app.visible = false
	system_app.visible = false
	map_app.visible = false
	_update_button_state()
	
	
func _run_power_generation():
	system_app._start_timer(system_app._get_click_count())

func _each_turn():
	_run_power_generation()
	var count = system_app._get_click_count()
	

func _update_button_state():
	$Taskbar/BusAppButton.disabled = bus_app.is_visible()
	$Taskbar/SystemButton.disabled = system_app.is_visible()
	$Taskbar/MapAppButton.disabled = map_app.is_visible()


func _bus_button_pressed():
	bus_app.show()
	bus_app._taskbar_button_pressed()
	_update_button_state()
	
func _system_button_pressed():
	system_app.show()
	system_app._taskbar_button_pressed()
	_update_button_state()
	
func _map_button_pressed():
	map_app.show()
	map_app._taskbar_button_pressed()
	_update_button_state()
