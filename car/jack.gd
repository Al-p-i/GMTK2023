extends Node2D

@onready var work_timer = $WorkTimer
@onready var progress_bar = $ProgressBar
@onready var use_jack_off = $UseJackOff
@onready var use_jack_on = $UseJackOn

var activated = false
var progress_per_tick = 7

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		#enum TOOL_TYPES { FIRE_EXTINGUISHER, SCREWDRIVER, JACK, TYRE, WIPER, FUEL }
		if Global.selected_tool == null:
			print("no tool selected")
		elif Global.selected_tool.tool_type == Global.TOOL_TYPES.JACK:
			toggle_jack()
		else:
			print("wrong tool selected ", Global.selected_tool)
		

func toggle_jack():
	if !activated:
		progress_bar.value = 0
		work_timer.start(0.25)
		progress_bar.show()
		use_jack_on.hide()
		use_jack_off.show()
	else:
		jack_off()


func _on_work_timer_timeout():
	progress()


func progress():
	progress_bar.value += progress_per_tick
	if progress_bar.value == 100:
		jack_on()

func jack_on():
	activated = true
	work_timer.stop()
	use_jack_on.show()
	use_jack_off.hide()
	print("jack on!")
	get_tree().call_group("jack_updates", "jack_on")
	
func jack_off():
	activated = false
	progress_bar.value = 0
	work_timer.stop()
	progress_bar.hide()
	use_jack_on.hide()
	use_jack_off.hide()
	print("jack off!")
	get_tree().call_group("jack_updates", "jack_off")
