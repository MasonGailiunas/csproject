extends mod_card


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super._process(delta)

func can_play() -> bool:
	get_parent().get_parent().get_placement_manager().current_preview.mult = mult
	return super.can_play()

func play_card():
	super.play_card()
