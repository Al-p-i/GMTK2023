extends Node2D

var main_menu:PackedScene = preload("res://menu.tscn")
var place_ends = ["st", "nd", "rd"]
@onready var place_pos = $Control/place/place
@onready var place_end = $Control/place/end
@onready var speed = $Control/speed/speed
@onready var time = $Control/time/time
@onready var point = $Control/point


func _ready():
	var color: String
	place("red", Global.red_place)
	place("green", Global.green_place)
	place("blue", Global.blue_place)
	
	place_pos.text = str(Global.red_place)
	place_end.text = place_ends[Global.red_place - 1]
	speed.text = str(Global.speed)
	time.text = str(Global.time)
	point.text = str(Global.point)
	
	#please add confetti animation


func place(color, pos):
	get_node("Control/%s" % pos).texture = load("res://assets/result/%s_%s.png" % [color, pos])


func _on_back_pressed():
	Trans.change_scene(main_menu)
