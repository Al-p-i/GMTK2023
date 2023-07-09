extends Node2D

@onready var progress_bar = $ProgressBar
@onready var use_jack_off = $UseJackOff
@onready var use_jack_on = $UseJackOn

var activated = false
var progress_per_tick = 20

signal jackActivated

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		if Global.selected_tool.tool_type == Global.TOOL_TYPES.JACK:
			progress_bar.show()
			use_jack_on.hide()
			use_jack_off.show()
			progress()

func increase_jack():
	if !activated:
		progress_bar.value = 0
		progress_bar.show()
		use_jack_on.hide()
		use_jack_off.show()
	else:
		jack_off()


func progress():
	progress_bar.value += progress_per_tick
	if progress_bar.value == 100:
		jack_on()

func jack_on():
	activated = true
	use_jack_on.show()
	use_jack_off.hide()
	emit_signal("jackActivated")
	get_tree().call_group("jack_updates", "jack_on")
	
func jack_off():
	activated = false
	progress_bar.value = 0
	progress_bar.hide()
	use_jack_on.hide()
	use_jack_off.hide()
	get_tree().call_group("jack_updates", "jack_off")
