extends Node

signal car_arrive_pitstop
signal car_leave_pitstop

@export var POSSIBLE_ACTIONS: Array[String]
const MAX_ACTIONS: int = 3

@onready var Car := $Car

var selected_actions: Array[String]

func _ready():
	selected_actions = genCarActions()
	print(selected_actions)
	
	moveCar(true)

func genCarActions() -> Array[String]:
	var toReturn: Array[String] = []
	var from = POSSIBLE_ACTIONS
	
	for i in range(0, MAX_ACTIONS):
		var k = from.pick_random()
		toReturn.append(k)
		from.erase(k)
	return toReturn

func _physics_process(delta):
	Car.move_and_slide()

func moveCar(isArrived: bool):
	if isArrived:
		Car.velocity.x = 350
	else: Car.velocity.x = -350
