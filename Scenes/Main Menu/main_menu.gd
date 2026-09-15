extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = false



func _on_continue_button_pressed() -> void:
	print("Continue")


func _on_new_run_button_pressed() -> void:
	print("New Run")


func _on_exit_button_pressed() -> void:
	get_tree().quit()
