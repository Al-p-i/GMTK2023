extends CarPart

var isProgressing: bool = false
var progress: int = 0

func _process(delta):
	if isProgressing:
		progress += 1
		if progress >= 80:
			fixPart()

func _on_area_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and Global.selected_tool and Global.selected_tool.tool_type == Global.TOOL_TYPES.WELDER:
		if event.is_pressed():
			isProgressing = true
		if not event.is_pressed():
			isProgressing = false
