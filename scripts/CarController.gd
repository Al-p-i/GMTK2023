extends Node

signal car_arrive_pitstop
signal car_leave_pitstop

@export var POSSIBLE_ACTIONS: Array[String] = []
@export var POSSIBLE_ACTION_OBJECTS: Array[PackedScene] = []
@onready var Car := $Car
@onready var StatusPanel := $"/root/Game/Car Status Panel"
@onready var BottomStatusPanel := $"/root/Game/Car Status Panel/Bottom Status"

const MAX_ACTIONS: int = 3

var selected_actions: Array[String] = []

const ENTER_POSITION: Vector2 = Vector2(-5000, 540)
const STOP_POSITION: Vector2 = Vector2(1000, 540)
const LEAVE_POSITION: Vector2 = Vector2(5000, 540)

var carFuelAmount: int = 50

func _ready():
	Car.position = ENTER_POSITION
	selected_actions = genCarActions()
	StatusPanel.brokeParts(selected_actions)
	BottomStatusPanel.updateIcons(selected_actions)
	
	var fuelRotation: float = (carFuelAmount / 100.0) * 120.0
	print(fuelRotation)
	BottomStatusPanel.updateFuelIcon(fuelRotation)
	
	moveCar(STOP_POSITION)

func genCarActions() -> Array[String]:
	var toReturn: Array[String] = []
	var from = POSSIBLE_ACTIONS
	
	for i in range(0, MAX_ACTIONS):
		var k = from.pick_random()
		toReturn.append(k)
		from.erase(k)
	return toReturn

func moveCar(targetPos: Vector2):
	var tween: Tween = get_tree().create_tween()
	
	tween.tween_property(Car, "position", targetPos, 5).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.tween_callback(carArrive)

func carArrive():
	emit_signal("car_arrive_pitstop")
