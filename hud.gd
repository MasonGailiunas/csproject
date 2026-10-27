extends CanvasLayer


@onready var currency_label: Label = %CurrencyLabel
@onready var energy_label: Label = %EnergyLabel
@onready var pause_menu: Control = %PauseMenu

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	Player.currency_changed.connect(_on_currency_changed)
	Player.energy_changed.connect(_on_energy_changed)
	_on_currency_changed(Player.currency)
	_on_energy_changed(Player.energy)
	

func _on_currency_changed(value: int) -> void:
	currency_label.text = "Coins:%d" % value

func _on_energy_changed(value: int) -> void:
	energy_label.text = "Energy: %d" % value

func _on_pause_button_pressed() -> void:
	_set_paused(true) 

func _on_resume_button_pressed() -> void:
	_set_paused(false)

func _set_paused(paused: bool) -> void:
	get_tree().paused = paused
	pause_menu.visible = paused
