extends Control

signal state_changed

@onready var bus_app = $"../BusApp"

@onready var powerAvail: bool
@onready var timeRemain: int

@onready var powerGenerated: int
@onready var turnNumber: int

@onready var timerRunning: bool
@onready var timeLeft
@onready var clickCount

func _ready():
	$GeneratePowerButton.disabled = true
	powerAvail = false
	
	$TitleBar/Close.pressed.connect(_on_close_pressed)
	$TitleBar/Min.pressed.connect(_on_min_pressed)
	
	$NextTurnButton.pressed.connect(_next_turn_pressed)
	$GeneratePowerButton.pressed.connect(_power_button_pressed)
	
	$TurnNumber.text = (str(0))
	$PowerGenerated.text = (str(0))
	clickCount = 0
	

func _get_click_count():
	return clickCount


func _start_timer(count):
	timeLeft = 15.0
	clickCount = count
	timerRunning = true
	$GeneratePowerButton.disabled = false

func _process(delta):
	if timerRunning:
		timeLeft -= delta
		if timeLeft <= 0:
			timeLeft = 0
			timerRunning = false
			$GeneratePowerButton.disabled = true
			bus_app._update_stats(clickCount)
			clickCount = 0
		_update_ui_from_busapp()
		$PowerGenerated.text = str(clickCount)
		
func _power_button_pressed():
	if timerRunning:
		clickCount += 1
		
func _next_turn_pressed():
	clickCount = 0
	bus_app._reset_turn()
	turnNumber += 1
	$TurnNumber.text = str(turnNumber)
	_start_timer(_get_click_count())
	
func _update_ui_from_busapp():
	$PowerGenerated.text = str(bus_app.powerGenerated)
	
func _taskbar_button_pressed():
	show()
	emit_signal("state_changed")
	
func _on_close_pressed():
	hide()
	emit_signal("state_changed")

func _on_min_pressed():
	hide()
	emit_signal("state_changed")
	
