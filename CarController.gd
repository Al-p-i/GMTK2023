extends Node

signal car_arrive_pitstop
signal car_leave_pitstop

@export var POSSIBLE_ACTIONS: Array[String] = []
@export var POSSIBLE_ACTION_OBJECTS: Array[PackedScene] = []
const MAX_ACTIONS: int = 3

@onready var Car := $Car

var selected_actions: Array[String] = []

const ENTER_POSITION: Vector2 = Vector2(0, 0)
const STOP_POSITION: Vector2 = Vector2(0, 0)
const LEAVE_POSITION: Vector2 = Vector2(0, 0)

func _ready():
	Car.position = ENTER_POSITION
	selected_actions = genCarActions()

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
	
