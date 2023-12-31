extends Node2D

@onready var view_tire_worn = $ViewTireWorn
@onready var view_tire_normal = $ViewTireNormal
@onready var bolt_screw = $BoltScrew
@onready var timer = $Timer
@onready var bolt = $Bolt
@onready var progress_bar = $ProgressBar
@onready var screw_position = $BoltScrew/ScrewPosition
@onready var screw_sfx = $ScrewSFX


var unscrew = true;

var index: int = 0

signal tireUnscrewed
signal tireScrewed
var scene_active = false

func start_unscrew():
	unscrew = true
	view_tire_worn.show()
	view_tire_normal.hide()
	bolt.show()
	progress_bar.value = 0
	scene_active = true
	show()
	
func start_screw():
	unscrew = false
	view_tire_worn.hide()
	view_tire_normal.show()
	bolt.hide()
	progress_bar.value = 0
	scene_active = true
	show()

func end():
	hide()
	screw_sfx.stop()
	scene_active = false
	get_node("/root/Game/Car Container").ToolContainer.enableTools()
	if unscrew:
		emit_signal("tireUnscrewed")
	else: emit_signal("tireScrewed")

func _process(delta):
	if !scene_active:
		return
	if bolt_screw:
		bolt_screw.global_position = get_global_mouse_position() #+ Vector2(250,250)
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if unscrew:
			bolt.rotate(-0.1)
			bolt_screw.rotate(0.003)
		else:
			bolt.rotate(0.1)
			bolt_screw.rotate(-0.003)
	else:
		if unscrew:
			bolt_screw.rotation = -1
		else:
			bolt_screw.rotation = 0
		

func _unhandled_input(event):
	if !scene_active:
		return
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		screw_sfx.play()
		var distance = screw_position.global_position.distance_to(bolt.global_position)
		if distance < 100:
			bolt.show()
			timer.start()
			progress_bar.show()

func _on_timer_timeout():
	if !scene_active:
		return
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var distance = screw_position.global_position.distance_to(bolt.global_position)
		progress_bar.value += max(0, 20 - sqrt(distance + 20))
		if progress_bar.value >= 100:
			end()
	else:
		screw_sfx.stop()
