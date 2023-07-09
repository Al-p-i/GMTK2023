extends Node

signal car_arrive_pitstop
signal car_leave_pitstop

@export var POSSIBLE_ACTIONS: Array[String] = []
@export var POSSIBLE_ACTION_OBJECTS: Array[PackedScene] = []
@onready var Car := $Car
@onready var ToolContainer := $"/root/Game/Tools Container"
@onready var StatusPanel := $"/root/Game/Car Status Panel"
@onready var BottomStatusPanel := $"/root/Game/Car Status Panel/Bottom Status"
@onready var MainTimer := $"/root/Game/Top Timer"

const MAX_ACTIONS: int = 3

var selected_actions: Array[String] = []

const ENTER_POSITION: Vector2 = Vector2(-5000, 540)
const STOP_POSITION: Vector2 = Vector2(1000, 540)
const LEAVE_POSITION: Vector2 = Vector2(5000, 540)

var carFuelAmount: float = 100.0

var fixedTireAmount: int = 0

func carCome():
	ToolContainer.disableTools()
	initCarProblems()
	moveCar(STOP_POSITION, Tween.TRANS_SINE, Tween.EASE_OUT).tween_callback(carArrive)

func initCarProblems():
	selected_actions = genCarActions()
	Car.position = ENTER_POSITION
	StatusPanel.brokeParts(selected_actions)
	BottomStatusPanel.updateIcons(selected_actions)
	
	carFuelAmount = randi_range(10, 100)
	var fuelRotation: float = (carFuelAmount / 100.0) * 120.0
	BottomStatusPanel.updateFuelIcon(fuelRotation)
	
	updateCarParts()

func genCarActions() -> Array[String]:
	var toReturn: Array[String] = selected_actions
	var from = POSSIBLE_ACTIONS
	
	for i in range(0, randi_range(2, MAX_ACTIONS)):
		var k = from.pick_random()
		if not toReturn.has(k):
			toReturn.append(k)
			from.erase(k)
	return toReturn

func moveCar(targetPos: Vector2, trans, ease) -> Tween:
	var tween: Tween = get_tree().create_tween()
	
	tween.tween_property(Car, "position", targetPos, 5).set_trans(trans).set_ease(ease)
	return tween

func carArrive():
	emit_signal("car_arrive_pitstop")
	ToolContainer.enableTools()
	MainTimer.startTimer(20)

func carLeave():
	moveCar(LEAVE_POSITION, Tween.TRANS_SINE, Tween.EASE_IN).tween_callback(carLeaved)

func carLeaved():
	emit_signal("car_leave_pitstop")

func updateCarParts():
	for i in range(0, Car.get_child_count()):
		if selected_actions.has(Car.get_child(i).problemId):
			Car.get_child(i).breakPart()

func _on_top_timer_no_time_left():
	carLeave()
	ToolContainer.leaveTool()
	ToolContainer.disableTools()
