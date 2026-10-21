extends Node

var sounds := {
	
	#Tower Sounds
	"TowerBuilt": preload("res://SoundStorage/TowerSounds/TowerPlace.mp3"),
	
	#Enemy Sounds
	"EnemyDeath": preload("res://SoundStorage/EnemySounds/bluh-output.mp3"),
	
	
	#Other Sounds
	"MenuClick":  preload("res://SoundStorage/OtherSounds/MenuClick.mp3"),
	
}

const POOL_SIZE := 12
var _players: Array[AudioStreamPlayer] = []

func _ready() -> void:
	for i in POOL_SIZE:
		var p := AudioStreamPlayer.new()
		p.bus = "SFX"
		add_child(p)
		_players.append(p)

func play(sound_name: String, volume_db := 0.0, pitch := 1.0) -> void:
	if not sounds.has(sound_name):
		push_warning("Missing sound: " + sound_name)
		return
	for p in _players:
		if not p.playing:
			p.stream = sounds[sound_name]
			p.volume_db = volume_db
			p.pitch_scale = pitch
			p.play()
			return
