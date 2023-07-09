extends Node2D
@onready var tyre_good = $TireGood
@onready var tyre_bad = $TireBad

enum STATE {FLAT_TYRE, NO_TYRE, NEW_TYRE}
var state: STATE = STATE.FLAT_TYRE
# Called when the node enters the scene tree for the first time.
func _ready():
	flat_tyre()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		if Global.selected_tool == null:
			print("no tool selected")
		elif Global.selected_tool.tool_type == Global.TOOL_TYPES.SCREWDRIVER:
			if state == STATE.FLAT_TYRE:
				get_tree().call_group("tyre_close_up", "start_unscrew")
				no_tyre()
		elif Global.selected_tool.tool_type == Global.TOOL_TYPES.TYRE:
			if state == STATE.NO_TYRE:
				get_tree().call_group("tyre_close_up", "start_screw")
				new_tyre()
		else:
			print("wrong tool selected ", Global.selected_tool)

func flat_tyre():
	tyre_good.hide()
	tyre_bad.show()
	state = STATE.FLAT_TYRE

func no_tyre():
	tyre_good.hide()
	tyre_bad.hide()
	state = STATE.NO_TYRE
	
func new_tyre():
	tyre_good.show()
	tyre_bad.hide()
	state = STATE.NEW_TYRE
