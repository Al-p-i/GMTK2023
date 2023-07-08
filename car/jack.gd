extends Node2D

@onready var label = $Label
@onready var work_timer = $WorkTimer
@onready var progress_bar = $ProgressBar

var activated = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		toggle_jack()
		
		
func toggle_jack():
	if !activated:
		progress_bar.value = 0
		work_timer.start(0.25)

	else:
		activated = false
		progress_bar.value = 0
		work_timer.stop()
		label.text = "Jack OFF"



func _on_work_timer_timeout():
	progress()


func progress():
	progress_bar.value += 10
	if progress_bar.value == 100:
		activated = true
		label.text = "Jack ON"