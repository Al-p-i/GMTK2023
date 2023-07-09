extends Node2D

@export var tools: Array[Node2D] = []
@onready var hightlight: Sprite2D = $"Highlight"
@onready var use_animation = $UseAnimation

var tool_cursor: Sprite2D = null
const toolWidth = 280
const toolGap = 30

var selectedToolIndex: int = -1 :
	set(value):
		selectedToolIndex = value
	get:
		return selectedToolIndex

func _ready():
	initTools()
	
func _process(delta):
	if tool_cursor:
		tool_cursor.global_position = get_global_mouse_position()
	if use_animation:
		use_animation.global_position = get_global_mouse_position() + Vector2(-70,50)
	

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
	Global.selected_tool = tools[selectedToolIndex]
	print('selected ', Global.selected_tool)
	
	for i in range(0, tools.size()):
		var targetPos = tools[i].position
		if i == selectedToolIndex:
			targetPos.y = -50
			tween.tween_property(tools[i], "position", targetPos, 0.25)
		else: 
			targetPos.y = 50
			tween.tween_property(tools[i], "position", targetPos, 0.25)
	
	highlightTool()
	init_tool_cursor()


func leaveTool():
	var tween = get_tree().create_tween().set_parallel(true)
	
	for i in range(0, tools.size()):
		var targetPos = tools[i].position
		targetPos.y = 0
		
		tween.tween_property(tools[i], "position", targetPos, 0.25)
	selectedToolIndex = -1
	hightlight.position.x = -9999
	remove_tool_cursor()

func init_tool_cursor():
	if !Global.selected_tool:
		return
		
	var tool_sprite = Sprite2D.new()
	match Global.selected_tool.tool_type:
		Global.TOOL_TYPES.FUEL:
			tool_sprite.texture = load("res://assets/use/use_fuel.png")
			tool_sprite.offset = Vector2(20,190)
		Global.TOOL_TYPES.WIPER:
			tool_sprite.texture = load("res://assets/use/use_wipe.png")
		Global.TOOL_TYPES.SCREWDRIVER:
			tool_sprite.texture = load("res://assets/use/use_screw.png")
		Global.TOOL_TYPES.FIRE_EXTINGUISHER:
			tool_sprite.texture = Global.selected_tool.sprite.texture
			tool_sprite.offset = Vector2(0,70)
		Global.TOOL_TYPES.JACK:
			tool_sprite.texture = load("res://assets/use/use_jack_off.png")
		Global.TOOL_TYPES.TYRE:
			tool_sprite.texture = load("res://assets/car/tire_good.png")
		_:
			tool_sprite.texture = Global.selected_tool.sprite.texture
	add_child(tool_sprite)
	tool_cursor = tool_sprite

func remove_tool_cursor():
	if tool_cursor:
		tool_cursor.queue_free()
		tool_cursor = null

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		if Global.selected_tool and Global.selected_tool.tool_type == Global.TOOL_TYPES.FIRE_EXTINGUISHER:
			use_animation.show()
			use_animation.play()
			if tool_cursor:
				tool_cursor.hide()
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_released():
		use_animation.hide()
		use_animation.stop()
		if tool_cursor:
			tool_cursor.show()
	
