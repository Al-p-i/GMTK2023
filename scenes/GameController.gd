extends Node2D

@onready var CarContainer := $"Car Container"

func _ready():
	CarContainer.carCome()

func _on_timer_timeout():
	print("Car is coming")
	
	CarContainer.carCome()
