extends CarPart

var isFuelConnected: bool = false

func _process(delta):
	if isFuelConnected:
		CarContainer.carFuelAmount += 0.001
		if CarContainer.carFuelAmount > 100: CarContainer.carFuelAmount = 100
		var fuelRotation: float = (CarContainer.carFuelAmount / 100.0) * 120.0
		print(fuelRotation)
		CarContainer.BottomStatusPanel.updateFuelIcon(fuelRotation)

func _on_area_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and Global.selected_tool and Global.selected_tool.tool_type == Global.TOOL_TYPES.FUEL and event.is_pressed():
		isFuelConnected = !isFuelConnected
