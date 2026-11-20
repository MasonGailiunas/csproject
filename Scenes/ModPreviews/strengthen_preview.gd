extends mod_preview
var mult

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super._process(delta)

func is_valid_spot() -> bool:
	return super.is_valid_spot()
	
func apply_mod():
	super.apply_mod()
	
func mod_effects(tower):
	tower.damage = (int) (tower.damage * mult)

func set_preview_mode(is_preview: bool) -> void:
	pass

func set_range_circle_visibility(is_visible: bool) -> void:
	pass
