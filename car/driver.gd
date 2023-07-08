extends Node2D

var wiping_in_progress = false
@onready var progress_bar = $ProgressBar
@onready var timer = $Timervar
var rng = RandomNumberGenerator.new()
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
		elif Global.selected_tool.tool_type == Global.TOOL_TYPES.WIPER:
			progress_bar.value += rng.randi_range(1,10)
		else:
			progress_bar.value -= rng.randi_range(1,10)
			print("wrong tool selected ", Global.selected_tool)
		
func toggle_wiping():
	wiping_in_progress = !wiping_in_progress
	if wiping_in_progress:
		progress_bar.show()
	else:
		progress_bar.hide()


