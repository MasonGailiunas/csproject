extends card
class_name mod_card

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func can_play() -> bool:
	# If on a tower
	return super.can_play()
	
func play_card():
	# Mod a certain tower
	super.play_card()
