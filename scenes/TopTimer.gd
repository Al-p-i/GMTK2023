extends Node2D

var primaryTime = 89 * 60 + 59
var secondaryTime = 90

@onready var primaryLabel: Label = $"Background/Primary"
@onready var secondaryLabel: Label = $"Background/Secondary"

func startTimer( t: int ):
	primaryTime = t * 60

func _on_timer_timeout():
	secondaryTime -= 5
	if secondaryTime == 0:
		secondaryTime = 90
		primaryTime -= 1
	
	primaryLabel.text = format(primaryTime)
	secondaryLabel.text = str(secondaryTime)

func format( time: int ) -> String:
	var minutes: int = time / 60
	var seconds: int = time % 60
	
	return str(minutes) + ":" + ("00" if str(seconds) == "0" else str(seconds))
