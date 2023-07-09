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

const status1 = "Status 1"
const status2 = "Status 2"
const status3 = "Status 3"
const status4 = "Status 4"
const status5 = "Status 5"
const status6 = "Status 6"

const borders: Array = ["res://assets/icon/icon_border_green.png", "res://assets/icon/icon_border_yellow.png", "res://assets/icon/icon_border_red.png"]

func updateIcons( problems: Array[String] ) -> void:
	for i in range(0, problems.size()):
		match (problems[i]):
			"engine_broken":
				get_node(engineStatus).texture = ResourceLoader.load(engineTextures[1])
				get_node(status1).texture = ResourceLoader.load(borders[2])
			"flat_tire":
				get_node(tireStatus).texture = ResourceLoader.load(tireTextures[1])
				get_node(status3).texture = ResourceLoader.load(borders[2])
			"rear_broken", "front_broken":
				get_node(wingStatus).texture = ResourceLoader.load(wingTextures[1])
				get_node(status4).texture = ResourceLoader.load(borders[2])
			"body_dirty":
				get_node(bodyStatus).texture = ResourceLoader.load(bodyTextures[1])
				get_node(status5).texture = ResourceLoader.load(borders[2])
			"driver_sad":
				get_node(driverStatus).texture = ResourceLoader.load(driverTextures[1])
				get_node(status6).texture = ResourceLoader.load(borders[2])

func repairEverything():
	get_node(engineStatus).texture = ResourceLoader.load(engineTextures[0])
	get_node(status1).texture = ResourceLoader.load(borders[0])
	get_node(status3).texture = ResourceLoader.load(borders[0])
	get_node(status5).texture = ResourceLoader.load(borders[0])
	get_node(status4).texture = ResourceLoader.load(borders[0])
	get_node(tireStatus).texture = ResourceLoader.load(tireTextures[0])
	get_node(wingStatus).texture = ResourceLoader.load(wingTextures[0])
	get_node(bodyStatus).texture = ResourceLoader.load(bodyTextures[0])
	
	get_node(driverStatus).texture = ResourceLoader.load(driverTextures[0])
	get_node(status6).texture = ResourceLoader.load(borders[0])

func updateFuelIcon( rotation: float ) -> void:
	get_node(fuelPin).rotation = deg_to_rad(rotation)
	if rotation >= 0 and rotation <= 35:
		get_node(status2).texture = ResourceLoader.load(borders[2])
	if rotation > 35 and rotation <= 80:
		get_node(status2).texture = ResourceLoader.load(borders[1])
	if rotation > 80 and rotation <= 100:
		get_node(status2).texture = ResourceLoader.load(borders[0])
