extends Node2D

var reparing = false 
@onready var progress_bar = $ProgressBar
@onready var progress_timer = $ProgressTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		toggle_repair()

func toggle_repair():
	if reparing:
		progress_timer.stop()
		progress_bar.value = 0
	else:
		progress_timer.start(0.25)
	reparing = !reparing

func _on_progress_timer_timeout():
	progress_bar.value += 5
	if progress_bar.value >= 100:
		reparing = false
