extends Control

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
	
	$NextTurnButton.pressed.connect(_next_turn_pressed)
	$GeneratePowerButton.pressed.connect(_power_pressed)
	
	$TurnNumber.text = (str(0))
	$PowerGenerated.text = (str(0))
	
	
func _start_timer():
	timeLeft = 15.0
	clickCount = 0
	timerRunning = true

func _process(delta):
	if timerRunning:
		timeLeft -= delta
		if timeLeft <= 0:
			timeLeft = 0
			timerRunning = false
			_on_timer_finished()
		powerGenerated.text = str(clickCount)

func _power_button_pressed()


func _power_pressed():
	if powerAvail:
		powerGenerated += 1
		
func _next_turn_pressed():
	turnNumber += 1

func _taskbar_button_pressed():
	show()
	emit_signal("state_changed")
	
