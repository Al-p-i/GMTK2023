extends CarPart

var isProgressing: bool = false
var progress: int = 0
@onready var animation = $"Fire Ext Anim"
@onready var fireAnimation = $"Fire Anim"

func _process(delta):
	if isBroken:
		fireAnimation.show()
		fireAnimation.play()
	if isProgressing and Global.selected_tool and Global.selected_tool.tool_type == Global.TOOL_TYPES.FIRE_EXTINGUISHER:
		if isBroken and animation:
			animation.global_position = get_global_mouse_position() + Vector2(-70,50)
			progress += 1
			fireAnimation.scale -= Vector2(0.01, 0.01)
			if progress >= 110:
				fireAnimation.hide()
				animation.hide()
				fixPart()

func _on_area_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and isBroken and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			isProgressing = true
			animation.show()
			animation.play()
		if not event.is_pressed():
			isProgressing = false
			animation.hide()
			animation.stop()
