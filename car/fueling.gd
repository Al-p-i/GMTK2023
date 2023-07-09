extends Node2D

@onready var progress_bar = $TextureProgressBar
@onready var fuel_timer = $Timer
@onready var fueling_hose = $FuelingHose
@onready var connected_sfx = $ConnectedSFX
@onready var disconnected_sfx = $DisconnectedSFX

var hose_attached = false
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
	hose_attached = !hose_attached
	if hose_attached:
		fueling_hose.show()
		progress_bar.show()
		fuel_timer.start()
		connected_sfx.play()
	else:
		fueling_hose.hide()
		progress_bar.hide()
		fuel_timer.stop()


func _on_timer_timeout():
	progress_bar.value += 2
