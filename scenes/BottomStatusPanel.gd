extends Node2D

const engineTextures = ["res://assets/icon/icon_engine_green.png", "res://assets/icon/icon_engine_red.png"]
const tireTextures = ["res://assets/icon/icon_tire_green.png", "res://assets/icon/icon_tire_red.png"]
const wingTextures = ["res://assets/icon/icon_wing_green.png", "res://assets/icon/icon_wing_red.png"]
const bodyTextures = ["res://assets/icon/icon_body_green.png", "res://assets/icon/icon_body_red.png"]
const driverTextures = ["res://assets/icon/icon_driver_green.png", "res://assets/icon/icon_driver_red.png"]

const engineStatus = "Status 1/Engine Status"
const tireStatus = "Status 3/Tire Status"
const wingStatus = "Status 4/Wing Status"
const bodyStatus = "Status 5/Body Status"
const driverStatus = "Status 6/Driver Status"

const fuelPin = "Status 2/Fuel Pin"

func updateIcons( problems: Array[String] ) -> void:
	for i in range(0, problems.size()):
		match (problems[i]):
			"engine_broken":
				get_node(engineStatus).texture = ResourceLoader.load(engineTextures[1])
			"tire_broken":
				get_node(tireStatus).texture = ResourceLoader.load(tireTextures[1])
			"rear_broken", "front_broken":
				get_node(wingStatus).texture = ResourceLoader.load(wingTextures[1])
			"body_dirty":
				get_node(bodyStatus).texture = ResourceLoader.load(bodyTextures[1])

func updateFuelIcon( rotation: float ) -> void:
	get_node(fuelPin).rotate(deg_to_rad(rotation))
