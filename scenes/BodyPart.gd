extends CarPart

var progress: int = 0
var isRepairing: bool = false

func _process(delta):
	if isRepairing and Global.selected_tool and Global.selected_tool.tool_type == fixTool:
		fixPart()

func _on_area_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			isRepairing = true
		if not event.is_pressed():
			isRepairing = false
