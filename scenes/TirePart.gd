extends CarPart

enum STATE {FLAT_TYRE, NO_TYRE, NEW_TYRE}
var state: STATE = STATE.NEW_TYRE

@export var index: int = 0
var isUnscrewed: bool = false
@onready var tireCloseupScene := $"/root/Game/Car Container/TireCloseup"

func _on_area_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		if Global.selected_tool and Global.selected_tool.tool_type == Global.TOOL_TYPES.SCREWDRIVER and isBroken:
			CarContainer.ToolContainer.disableTools()
			tireCloseupScene.start_unscrew()
			tireCloseupScene.index = index
		if Global.selected_tool and Global.selected_tool.tool_type == Global.TOOL_TYPES.TYRE and isBroken and isUnscrewed:
			tireCloseupScene.start_screw()
			tireCloseupScene.index = index

func _on_tire_closeup_tire_unscrewed():
	if tireCloseupScene.index == index:
		texture = null
		isUnscrewed = true

func _on_tire_closeup_tire_screwed():
	if tireCloseupScene.index == index:
		fixPart()

func fixPart():
	isBroken = false
	repaired()
	CarContainer.fixedTireAmount += 1
	if CarContainer.fixedTireAmount == 4:
		CarContainer.BottomStatusPanel.repairEverything()
		CarContainer.BottomStatusPanel.updateIcons(CarContainer.selected_actions)
	CarContainer.StatusPanel.repairTire(index - 1)
