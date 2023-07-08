extends Node2D

@export var tools: Array[Node2D] = []
@onready var hightlight: Sprite2D = $"Highlight"

const toolWidth = 280
const toolGap = 30

var selectedToolIndex: int = -1 :
	set(value):
		selectedToolIndex = value
	get:
		return selectedToolIndex

func _ready():
	initTools()

func initTools():
	var width = ProjectSettings.get_setting("display/window/size/viewport_width")
	var start = ((width - ((6 * toolWidth) + (5 * toolGap))) / 2) + toolWidth / 2
	
	for i in range(0, tools.size()):
		tools[i].position.x = start + (i * (toolWidth + toolGap))

func highlightTool():
	var width = ProjectSettings.get_setting("display/window/size/viewport_width")
	var start = ((width - ((6 * toolWidth) + (5 * toolGap))) / 2) + toolWidth / 2
	
	hightlight.position.x = start + (selectedToolIndex * (toolWidth + toolGap))

func setTool(k: int):
	var tween = get_tree().create_tween().set_parallel(true)
	selectedToolIndex = k
	
	for i in range(0, tools.size()):
		var targetPos = tools[i].position
		if i == selectedToolIndex:
			targetPos.y = -50
			tween.tween_property(tools[i], "position", targetPos, 0.25)
		else: 
			targetPos.y = 50
			tween.tween_property(tools[i], "position", targetPos, 0.25)
	
	highlightTool()

func leaveTool():
	var tween = get_tree().create_tween().set_parallel(true)
	
	for i in range(0, tools.size()):
		var targetPos = tools[i].position
		targetPos.y = 0
		
		tween.tween_property(tools[i], "position", targetPos, 0.25)
	selectedToolIndex = -1
	hightlight.position.x = -9999
