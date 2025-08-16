extends Control

signal stateChanged

var capacity := 0
var speed := 0
var frequency := 0
var reliability := 0
var efficiency := 0

var capacityPrice := 50
var speedPrice := 50
var frequencyPrice := 50
var reliabilityPrice := 50
var efficiencyPrice := 50

var level:= 0
var powerGenerated := 0
var powerRequired := 0
var moneyGenerated := 0
var totalMoney := 0

func _ready():
	$TitleBar/Close.pressed.connect(_on_close_pressed)
	$TitleBar/Min.pressed.connect(_on_min_pressed)
	$UpgradesArea/CapacityButton.pressed.connect(func(): _on_upgrade("capacity"))
	$UpgradesArea/SpeedButton.pressed.connect(func(): _on_upgrade("speed"))
	$UpgradesArea/FrequencyButton.pressed.connect(func(): _on_upgrade("frequency"))
	$UpgradesArea/ReliabilityButton.pressed.connect(func(): _on_upgrade("reliability"))
	$UpgradesArea/EfficiencyButton.pressed.connect(func(): _on_upgrade("efficiency"))
	_update_all()

func _on_upgrade(upgrade: String):
	var price = _get_price(upgrade)
	
	if totalMoney >= price:
		totalMoney -= price
		match upgrade:
			"capacity": capacity += 1
			"speed": speed += 1
			"frequency": frequency += 1
			"reliability": reliability += 1
			"efficiency": efficiency += 1
		_update_all()

func _get_price(upgrade: String) -> int:
	match upgrade:
		"capacity": return capacityPrice
		"speed": return speedPrice
		"frequency": return frequencyPrice
		"reliability": return reliabilityPrice
		"efficiency": return efficiencyPrice
		
	return 999999

func update_power(power:int):
	powerGenerated = power
	powerRequired = 50 + (level * 15)
	var baseMoney = max(0, (level) * 15)
	var bonusMoney = max(0, powerGenerated - powerRequired) * 2
	moneyGenerated = baseMoney + bonusMoney

func _update_all():
	_determine_level()
	_update_prices()
	_update_progressbars()
	_update_text()
	_update_button_states()
	
func _determine_level() -> int:
	return min(capacity, speed, frequency, reliability, efficiency)
	
func _update_prices():
	capacityPrice = 50 + capacity * 50
	speedPrice = 50 + speed * 50
	frequencyPrice = 50 + frequency * 50
	reliabilityPrice = 50 + reliability * 50
	efficiencyPrice = 50 + efficiency * 50
	
func _update_stats(clicked: int):
	powerGenerated += clicked
	powerRequired = 50 + (level * 15)
	
	if (powerGenerated >= powerRequired):
		var baseMoney = max(0, (level-2) * 15)
		var bonusMoney = max(0, powerGenerated-powerRequired) *2
		moneyGenerated = baseMoney + bonusMoney
		totalMoney += moneyGenerated
		if powerGenerated < 0:
			powerGenerated = 0
			
	_update_text()
	_update_button_states()
	powerRequired = 50 + (level * 50)
	_update_text()
	_update_button_states()

func _reset_turn():
	powerGenerated = 0
	powerRequired = 50 + (level * 15)
	moneyGenerated = 0
	_update_text()

func _update_progressbars():
	$UpgradesArea/CapacityBar._update_capacity(capacity)
	$UpgradesArea/SpeedBar._update_speed(speed)
	$UpgradesArea/FrequencyBar._update_frequency(frequency)
	$UpgradesArea/ReliabilityBar._update_reliability(reliability)
	$UpgradesArea/EfficiencyBar._update_efficiency(efficiency)
	$StatsArea/LevelBar._update_level(_determine_level())
	
func _update_text():
	$UpgradesArea/CapacityPriceText.text = str(capacityPrice)
	$UpgradesArea/SpeedPriceText.text = str(speedPrice)
	$UpgradesArea/FrequencyPriceText.text = str(frequencyPrice)
	$UpgradesArea/ReliabilityPriceText.text = str(reliabilityPrice)
	$UpgradesArea/EfficiencyPriceText.text = str(efficiencyPrice)
	$UpgradesArea/AvailableMoneyText.text = str(totalMoney)
	$StatsArea/PwrGeneratedNumber.text = str(powerGenerated)
	$StatsArea/PwrReqdNumber.text = str(powerRequired)
	$StatsArea/MoneyGeneratedNumber.text = str(moneyGenerated)
	
func _update_button_states():
	$UpgradesArea/CapacityButton.disabled = totalMoney < capacityPrice or capacity >= 10
	$UpgradesArea/SpeedButton.disabled = totalMoney < speedPrice or speed >= 10
	$UpgradesArea/FrequencyButton.disabled = totalMoney < frequencyPrice or frequency >= 10
	$UpgradesArea/ReliabilityButton.disabled = totalMoney < reliabilityPrice or reliability >= 10
	$UpgradesArea/EfficiencyButton.disabled = totalMoney < efficiencyPrice or efficiency >= 10
	
func _on_close_pressed():
	hide()
	emit_signal("stateChanged")

func _on_min_pressed():
	hide()
	emit_signal("stateChanged")
	
func _taskbar_button_pressed():
	show()
	emit_signal("stateChanged")
