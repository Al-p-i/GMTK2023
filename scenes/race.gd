extends Node2D

@onready var _mini_car: PackedScene = preload("res://scenes/mini_car.tscn")
@onready var result: PackedScene = preload("res://scenes/result.tscn")
@onready var cars = [$"red track/red", $"green track/green", $"blue track/blue"]
@onready var red_track = $"red track"
@onready var green_track = $"green track"
@onready var blue_track = $"blue track"
@onready var red_car = $"red track/red/mini_car"
@onready var green_car = $"green track/green/mini_car"
@onready var blue_car = $"blue track/blue/mini_car"
@onready var max_lap_txt = $status/laps/end
@onready var current_lap_txt = $status/laps/count
@onready var place_board = $status/place
@onready var red_place = $status/place/red
@onready var green_place = $status/place/green
@onready var blue_place = $status/place/blue
var red_pitstop: bool
var green_pitstop: bool
var blue_pitstop: bool
var max_lap:int = 3

func _ready():
	max_lap_txt.text = str("/", max_lap)


func _process(delta):
	var current_lap:int = red_car.current_lap
	current_lap_txt.text = str(current_lap)
	
	if red_car.current_lap > green_car.current_lap and red_car.current_lap > blue_car.current_lap:
		place_board.move_child(red_place, 0)
	
	if green_car.current_lap > red_car.current_lap and green_car.current_lap > blue_car.current_lap:
		place_board.move_child(green_place, 0)
	
	if blue_car.current_lap > red_car.current_lap and blue_car.current_lap > green_car.current_lap:
		place_board.move_child(blue_place, 0)
	
	_pitstop(red_car, red_track)
	_pitstop(green_car, green_track)
	_pitstop(blue_car, blue_track)
	
	
	if current_lap < max_lap:
		if not red_pitstop:
			accelerating(red_car)
		cars[0].progress += red_car.current_speed + 2
		
		if not green_pitstop:
			accelerating(green_car)
		cars[1].progress += green_car.current_speed
		
		if not blue_pitstop:
			accelerating(blue_car)
		cars[2].progress += blue_car.current_speed + 3
	elif green_car.current_lap >= max_lap and blue_car.current_lap >= max_lap:
		game_over()
		cars[0].progress += 1
		cars[1].progress += 1
		cars[2].progress += 1
	else:
		game_over()
		cars[0].progress += 1
		cars[1].progress += 1
		cars[2].progress += 1

func accelerating(car):
	if car.current_speed < car.max_speed:
		car.current_speed += randf_range(0, car.acceleration)


func _on_corner_body_entered(body):
	body.current_speed -= body.cornering_slow

func _on_finish_line_body_entered(body):
	body.current_lap += 1

func _pitstop(car, track):
	if car.current_lap % 2 == 1: 
		await get_tree().create_timer(3).timeout
		track.curve.set_point_position(10, Vector2(785, 920))
		track.curve.set_point_position(11, Vector2(1207, 920))
	else:
		track.curve.set_point_position(10, Vector2(785, 787))
		track.curve.set_point_position(11, Vector2(1207, 787))

func _on_pitstop_body_entered(body):
	match body:
		red_car:
			red_pitstop = true
			body.current_speed = 0.1
			hide()
		green_car:
			green_pitstop = true
			body.current_speed = 1
		blue_car:
			blue_pitstop = true
			body.current_speed = 1

func _on_pitstop_body_exited(body):
	match body:
		red_car:
			red_pitstop = false
		green_car:
			green_pitstop = false
		blue_car:
			blue_pitstop = false

func game_over():
	Global.red_place = get_node("status/place/red").get_index() + 1
	Global.green_place = get_node("status/place/green").get_index() + 1
	Global.blue_place = get_node("status/place/blue").get_index() + 1
	await get_tree().create_timer(2).timeout
	Trans.change_scene(result)


"""
	if cars[0].progress > cars[1].progress and cars[0].progress > cars[2].progress:
		place_board.move_child(red_place, 0)
	elif cars[1].progress > cars[0].progress and cars[1].progress > cars[2].progress:
		place_board.move_child(green_place, 0)
	elif cars[2].progress > cars[0].progress and cars[2].progress > cars[1].progress:
		place_board.move_child(blue_place, 0)
	"""









