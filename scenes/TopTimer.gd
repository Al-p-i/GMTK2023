extends Node2D

var primaryTime = 9999
var secondaryTime = 90

@onready var primaryLabel: Label = $"Background/Primary"
@onready var secondaryLabel: Label = $"Background/Secondary"
@onready var timer: Timer = $Timer

signal noTimeLeft

func startTimer( t: int ):
	primaryTime = t
	timer.start()

func stopTimer():
	timer.stop()
	
	primaryLabel.text = "--:--"
	secondaryLabel.text = "--"

func _on_timer_timeout():
	
	if primaryTime <= 0 and secondaryTime == 5:
		stopTimer()
		emit_signal("noTimeLeft")
		return
	
	secondaryTime -= 5
	if secondaryTime == 0:
		secondaryTime = 90
		primaryTime -= 1
	
	primaryLabel.text = format(primaryTime)
	secondaryLabel.text = str(secondaryTime)

func format( time: int ) -> String:
	var minutes: int = time / 60
	var seconds: int = time % 60
	
	return ("0" + str(minutes) if minutes < 10 else str(minutes)) + ":" + ("0" + str(seconds) if seconds < 10 else str(seconds)) 
