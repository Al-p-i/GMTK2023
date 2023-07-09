extends CarPart

var isProgressing: bool = false
var progress: int = 0

@onready var particle := $Particle

func _process(delta):
	if isBroken and isProgressing:
		progress += 1
		if progress >= 100:
			fixPart()

func _on_area_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and isBroken and event.button_index == MOUSE_BUTTON_LEFT:
		if Global.selected_tool and Global.selected_tool.tool_type == Global.TOOL_TYPES.POMPOM:
			if event.is_pressed():
				isProgressing = true
				particle.show()
				particle.emitting = true
			if not event.is_pressed():
				isProgressing = false
				particle.emitting = false
				particle.hide()
