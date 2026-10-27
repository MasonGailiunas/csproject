extends Node

signal currency_changed(new_value: int)
signal energy_changed(new_value: int)

var max_energy := 100      #FIX LATER

var currency := 0:
	set(value):
		currency = value
		currency_changed.emit(currency)


var energy := 100:
	set(value):
		energy = value
		energy_changed.emit(energy)
