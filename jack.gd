extends Node2D

@onready var label = $Label

var activated = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		activated = !activated
		toggle_jack()
		
		
func toggle_jack():
	if activated:
		label.text = "Jack ON"
	else:
		label.text = "Jack OFF"

