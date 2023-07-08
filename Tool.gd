extends Button

enum TOOL_TYPES { FIRE_EXTINGUISHER, SCREWDRIVER, JACK, TYRE, WIPER }
@export var tool_type: TOOL_TYPES

var ui: Control = null

func _ready():
	ui = get_parent()

func _on_pressed():
	if ui.selectedToolIndex == get_index():
		ui.leaveTool()
	else: get_parent().setTool(get_index())
