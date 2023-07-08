extends Control

@export var tools: Array[Button] = []
 
var selectedToolIndex: int = -1 :
	set(value):
		selectedToolIndex = value
	get:
		return selectedToolIndex

func setTool(k: int):
	var tween = get_tree().create_tween()
	selectedToolIndex = k
	
	for i in range(0, tools.size()):
		var targetPos = tools[i].position
		if i == selectedToolIndex:
			targetPos.y = 700
			tools[i].disabled = false
			tween.parallel().tween_property(tools[i], "position", targetPos, 0.125)
		else: 
			targetPos.y = 800
			tools[i].disabled = true
			tween.parallel().tween_property(tools[i], "position", targetPos, 0.125)
	tween.tween_callback(tween.kill)

func leaveTool():
	var tween = get_tree().create_tween()
	
	for i in range(0, tools.size()):
		var targetPos = tools[i].position
		targetPos.y = 750
		tools[i].disabled = false
		
		tween.parallel().tween_property(tools[i], "position", targetPos, 0.125)
	tween.tween_callback(tween.kill)
	selectedToolIndex = -1
