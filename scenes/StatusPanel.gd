extends Node2D

var frontStatus = "Top Car Model/Front Status"
var bodyStatus = "Top Car Model/Body Status"
var rearStatus = "Top Car Model/Rear Status"
var driverStatus = "Top Car Model/Driver Status"
var engineStatus = "Top Car Model/Engine Status"
var fuelStatus = "Top Car Model/Fuel Status"
@export var tiresStatus: Array[Sprite2D] = []

const frontTextures: Array = ["res://assets/stat/stat_front_green.png", "res://assets/stat/stat_front_red.png"]
const bodyTextures: Array = ["res://assets/stat/stat_body_green.png", "res://assets/stat/stat_body_red.png"]
const rearTextures: Array = ["res://assets/stat/stat_rear_green.png", "res://assets/stat/stat_rear_red.png"]
const driverTextures: Array = ["res://assets/stat/stat_driver_green.png", "res://assets/stat/stat_driver_red.png"]
const engineTextures: Array = ["res://assets/stat/stat_engine_green.png", "res://assets/stat/stat_engine_red.png"]
const fuelTextures: Array = ["res://assets/stat/stat_fuel_green.png", "res://assets/stat/stat_fuel_red.png"]
const tireTextures: Array = ["res://assets/stat/stat_tire_green.png", "res://assets/stat/stat_tire_red.png"]

func brokeParts( problems: Array[String] ) -> void:
	for i in range(0, problems.size()):
		match (problems[i]):
			"front_broken":
				get_node(frontStatus).texture = ResourceLoader.load(frontTextures[1])
			"rear_broken":
				get_node(rearStatus).texture = ResourceLoader.load(rearTextures[1])
			"body_dirty":
				get_node(bodyStatus).texture = ResourceLoader.load(bodyTextures[1])
			"engine_broken":
				get_node(engineStatus).texture = ResourceLoader.load(engineTextures[1])
			"flat_tire":
				for j in range(0, tiresStatus.size()):
					get_node(tiresStatus[j].get_path()).texture = ResourceLoader.load(tireTextures[1])

func repairEverything():
	get_node(frontStatus).texture = ResourceLoader.load(frontTextures[0])
	get_node(rearStatus).texture = ResourceLoader.load(rearTextures[0])
	get_node(bodyStatus).texture = ResourceLoader.load(bodyTextures[0])
	get_node(engineStatus).texture = ResourceLoader.load(engineTextures[0])
	for j in range(0, tiresStatus.size()):
		get_node(tiresStatus[j].get_path()).texture = ResourceLoader.load(tireTextures[0])

func repairTire(index):
	get_node(tiresStatus[index].get_path()).texture = ResourceLoader.load(tireTextures[0])
