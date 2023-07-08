extends Node2D


@onready var progress_bar = $ProgressBar
@onready var fuel_timer = $Timer
var fueling_in_progress = false


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
		elif Global.selected_tool.tool_type == Global.TOOL_TYPES.FUEL:
			toggle_fueling()
		else:
			print("wrong tool selected ", Global.selected_tool)
		
func toggle_fueling():
	fueling_in_progress = !fueling_in_progress
	if fueling_in_progress:
		progress_bar.show()
		fuel_timer.start()
	else:
		progress_bar.hide()
		fuel_timer.stop()


func _on_timer_timeout():
	progress_bar.value += 5
