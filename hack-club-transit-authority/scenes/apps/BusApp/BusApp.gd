extends Control

signal state_changed

@onready var capacity: int
@onready var speed: int
@onready var frequency: int
@onready var reliability: int
@onready var efficiency: int

@onready var capacityPrice: int
@onready var speedPrice: int
@onready var frequencyPrice: int
@onready var reliabilityPrice: int
@onready var efficiencyPrice: int

@onready var level: int

@onready var powerGenerated: int
@onready var powerRequired: int
@onready var moneyGenerated: int

func _ready():
	$TitleBar/Close.pressed.connect(_on_close_pressed)
	$TitleBar/Min.pressed.connect(_on_min_pressed)
	
	$UpgradesArea/CapacityButton.pressed.connect(_on_capacity_upgrade)
	capacity = 0
	$UpgradesArea/SpeedButton.pressed.connect(_on_speed_upgrade)
	speed = 0
	$UpgradesArea/FrequencyButton.pressed.connect(_on_frequency_upgrade)
	frequency = 0
	$UpgradesArea/ReliabilityButton.pressed.connect(_on_reliability_upgrade)
	reliability = 0
	$UpgradesArea/EfficiencyButton.pressed.connect(_on_efficiency_upgrade)
	efficiency = 0
	
	capacityPrice = 0
	$UpgradesArea/CapacityPriceText.text = (str(capacityPrice))
	speedPrice = 0
	$UpgradesArea/SpeedPriceText.text = (str(speedPrice))
	frequencyPrice = 0
	$UpgradesArea/FrequencyPriceText.text = (str(frequencyPrice))
	reliabilityPrice = 0
	$UpgradesArea/ReliabilityPriceText.text = (str(reliabilityPrice))
	efficiencyPrice = 0
	$UpgradesArea/ReliabilityPriceText.text = (str(reliabilityPrice))
	
	level = 0
	powerGenerated = 0
	powerRequired = 0
	moneyGenerated = 0
	
	_each_turn(0)

func _process(delta):
	_each_turn(0)

func _each_turn(moneyNow):
	powerGenerated = 100 + (level * 20)
	powerRequired = 50 + (level * 25)
	
	var baseMoney = max(0, (level-2) * 15)
	var bonusMoney = max(0, powerGenerated - powerRequired) *2
	moneyGenerated = baseMoney + bonusMoney
	
	_determine_level()
	_upgrade_availability_bg(moneyNow)
	
	$StatsArea/LevelBar._update_level(level)
	$StatsArea/PwrGeneratedNumber.text = (str(powerGenerated))
	$StatsArea/PwrReqdNumber.text = (str(powerRequired))
	$StatsArea/MoneyGeneratedNumber.text = (str(moneyGenerated))
	
	$UpgradesArea/AvailableMoneyText.text = (str(moneyNow))
	
	$UpgradesArea/CapacityBar._update_capacity(capacity)
	$UpgradesArea/SpeedBar._update_speed(speed)
	$UpgradesArea/FrequencyBar._update_frequency(frequency)
	$UpgradesArea/ReliabilityBar._update_reliability(reliability)
	$UpgradesArea/EfficiencyBar._update_efficiency(efficiency)
	
	capacityPrice = 50 + (capacity * 50)
	speedPrice = 50 + (speed * 50)
	frequencyPrice = 50 + (frequency * 50)
	reliabilityPrice = 50 + (reliability * 50)
	efficiencyPrice = 50 + (efficiency * 50)
	$UpgradesArea/CapacityPriceText.text = (str(capacityPrice))
	$UpgradesArea/SpeedPriceText.text = (str(speedPrice))
	$UpgradesArea/FrequencyPriceText.text = (str(frequencyPrice))
	$UpgradesArea/ReliabilityPriceText.text = (str(reliabilityPrice))
	$UpgradesArea/EfficiencyPriceText.text = (str(efficiencyPrice))
	

func _on_capacity_upgrade(moneyNow):
	if (moneyNow >= capacityPrice):
		moneyNow -= capacityPrice
		capacity += 1
	
func _on_speed_upgrade(moneyNow):
	if (moneyNow >= speedPrice):
		moneyNow -= speedPrice
		speed += 1
	
func _on_frequency_upgrade(moneyNow):
	if (moneyNow >= frequencyPrice):
		moneyNow -= frequencyPrice
		frequency += 1
	
func _on_reliability_upgrade(moneyNow):
	if (moneyNow >= reliabilityPrice):
		moneyNow -= reliabilityPrice
		frequency += 1
	
func _on_efficiency_upgrade(moneyNow):
	if (moneyNow >= efficiencyPrice):
		moneyNow -= efficiencyPrice
		frequency += 1
	
func _upgrade_availability_bg(moneyNow) :
	if (moneyNow < capacityPrice):
		$UpgradesArea/CapacityButton.disabled = true
	elif (capacity >= 10):
		$UpgradesArea/CapacityButton.disabled = true
	else:
		$UpgradesArea/CapacityButton.disabled = false
	
	if (moneyNow < speedPrice):
		$UpgradesArea/SpeedButton.disabled = true
	elif (speed >= 10):
		$UpgradesArea/SpeedButton.disabled = true
	else:
		$UpgradesArea/SpeedButton.disabled = false
	
	if (moneyNow < frequencyPrice):
		$UpgradesArea/FrequencyButton.disabled = true
	elif (frequency >= 10):
		$UpgradesArea/FrequencyButton.disabled = true
	else:
		$UpgradesArea/FrequencyButton.disabled = false
		
	if (moneyNow < reliabilityPrice):
		$UpgradesArea/ReliabilityButton.disabled = true
	elif (reliability >= 10):
		$UpgradesArea/ReliabilityButton.disabled = true
	else:
		$UpgradesArea/ReliabilityButton.disabled = false
	
	if (moneyNow < efficiencyPrice):
		$UpgradesArea/EfficiencyButton.disabled = true
	elif (efficiency >= 10):
		$UpgradesArea/EfficiencyButton.disabled = true
	else:
		$UpgradesArea/EfficiencyButton.disabled = false
	
func _determine_level():
	var targetLevel = level + 1
	if min(capacity, speed, frequency, reliability, efficiency) >= targetLevel:
		level = targetLevel
	if (level > 10):
		level = 10
	if (level < 0):
		level = 0
	
	
func _on_close_pressed():
	hide()
	emit_signal("state_changed")
	
func _on_min_pressed():
	hide()
	emit_signal("state_changed")
	
func _taskbar_button_pressed():
	show()
	emit_signal("state_changed")
