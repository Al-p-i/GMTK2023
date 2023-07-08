extends Node2D

@export var tool_type: Global.TOOL_TYPES
@export var tool_sprite: CompressedTexture2D

var ui: Node2D = null
@onready var sprite: Sprite2D = $"Sprite"

func _ready():
	sprite.texture = tool_sprite
	ui = get_parent()

func _on_area_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		if ui.selectedToolIndex == get_index():
			ui.leaveTool()
		else:
			ui.leaveTool()
			get_parent().setTool(get_index())
