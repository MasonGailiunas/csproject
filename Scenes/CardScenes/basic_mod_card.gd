extends card
class_name mod_card
@export var mult : float = 0

var selected_tower
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $RichTextLabel.text.contains("{m}"):
		$RichTextLabel.text = $RichTextLabel.text.replace("{m}", str(mult))
	super._process(delta)

func can_play() -> bool:
	var placement_manager_ref = get_parent().get_parent().get_placement_manager()
	if placement_manager_ref.current_preview.is_valid_spot():
		return super.can_play()
	return false
	
func play_card():
	var placement_manager_ref = get_parent().get_parent().get_placement_manager()
	placement_manager_ref.current_preview.apply_mod()
	super.play_card()
