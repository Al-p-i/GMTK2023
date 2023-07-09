extends CharacterBody2D

@export_enum("red", "green", "blue") var car_color: String
@onready var color = $color
var acceleration:float = 0.2
var max_speed:float = 10
var cornering_slow:float = 2.0
var current_speed:float
var current_lap:int


func _ready():
	color.texture = load("res://assets/view/mini_%s.png" % car_color)

func _process(delta):
	if car_color == "red":
		if current_speed > Global.speed:
			Global.speed = current_speed
