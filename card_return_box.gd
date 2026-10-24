extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $"../Sprite2D".modulate.a < 0.05: $"../Sprite2D".modulate.a+= 0.001

func _on_area_entered(area: Area2D) -> void:
	var card = area.get_parent()
	if card.is_in_group("cards"):
		card.in_return_box = true
		get_parent().hide()
		print("enter")

func _on_area_exited(area: Area2D) -> void:
	var card = area.get_parent()
	
	if card.is_in_group("cards"):
		card.in_return_box = false
		$"../Sprite2D".modulate.a = 0
		get_parent().show()
		print("exit")
