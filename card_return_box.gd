extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_entered(area: Area2D) -> void:
	var card = area.get_parent()
	if card.is_in_group("cards"):
		print("enter")

func _on_area_exited(area: Area2D) -> void:
	var card = area.get_parent()
	
	if card.is_in_group("cards"):
		print("exit")
