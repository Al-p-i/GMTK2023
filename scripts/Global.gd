extends Node

enum TOOL_TYPES { FIRE_EXTINGUISHER, SCREWDRIVER, JACK, TYRE, WIPER, FUEL }
var current_camera = null

var selected_tool: Node2D = null

var red_place: int = 1
var green_place: int = 2
var blue_place: int = 3

var speed: int
var time: int
var point: int

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func camera_shake(strength, time):
	if(current_camera != null):
		current_camera.camera_shake(strength, time);

func play_SFX(audio, bus:String="Master"):
#	if !audio_player.is_playing() and Global.can_playSFX:
#	Global.can_playSFX = false
	var audio_player = AudioStreamPlayer.new()
	add_child(audio_player) 
	audio_player.stream = audio
	audio_player.set_bus(bus)
	audio_player.play()
	await audio_player.finished
	audio_player.queue_free()
