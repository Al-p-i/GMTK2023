extends Node2D

@export var tool_type: Global.TOOL_TYPES
@export var tool_sprite: CompressedTexture2D

var ui: Node2D = null
@onready var sprite: Sprite2D = $"Sprite"
@onready var collision: CollisionShape2D = $"Area/Collider"

@onready var disabledShader = preload("res://scenes/BaseToolDisabled.gdshader")

var isDisabled: bool = false

func _ready():
	sprite.texture = tool_sprite
	ui = get_parent()

func disable():
	isDisabled = true
	collision.disabled = true
	sprite.material.shader = disabledShader

func enable():
	isDisabled = false
	collision.disabled = false
	sprite.material.shader = null

func hideSprite():
	sprite.hide()

func showSprite():
	sprite.show()

func _on_area_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		if isDisabled: return
		if ui.selectedToolIndex == get_index():
			ui.leaveTool()
		else:
			get_parent().setTool(get_index())
