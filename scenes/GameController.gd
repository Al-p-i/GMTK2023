extends Node2D

@onready var CarContainer := $"Car Container"
@onready var MainTimer := $"Timer"

func _ready():
	CarContainer.carCome()

func _on_timer_timeout():
	CarContainer.carCome()
	MainTimer.stop()

func _on_car_container_car_leave_pitstop():
	MainTimer.start()
