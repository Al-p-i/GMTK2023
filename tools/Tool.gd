extends Node2D
class_name Tool

var is_ready = true
enum ToolType {FIRE_EXTINGUISHER, SCREWDRIVER, JACK, TYRE}
@export var type: ToolType

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		if !is_ready:
			print(ToolType.keys()[type], " is reloading")
		else:
			use_tool()

func use_tool():
	print("using ", ToolType.keys()[type])
