extends Sprite2D
class_name CarPart

@export var fixTool: Global.TOOL_TYPES = Global.TOOL_TYPES.FIRE_EXTINGUISHER

@export var problemId: String = ""
@export var goodPart: String = ""
@export var badPart: String = ""

@onready var CarContainer = $"/root/Game/Car Container"

var isBroken = false

func broken():
	isBroken = true
	texture = ResourceLoader.load(badPart)
	
func repaired():
	texture = ResourceLoader.load(goodPart)

func breakPart():
	broken()

func fixPart():
	isBroken = false
	repaired()
	CarContainer.selected_actions.erase(problemId)
	CarContainer.StatusPanel.repairEverything()
	CarContainer.BottomStatusPanel.repairEverything()
	CarContainer.StatusPanel.brokeParts(CarContainer.selected_actions)
	CarContainer.BottomStatusPanel.updateIcons(CarContainer.selected_actions)
