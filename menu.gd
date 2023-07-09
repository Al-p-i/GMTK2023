extends Node2D

@onready var credit := $Control/credits_screen
var game_screen :PackedScene = preload("res://scenes/Game.tscn")

@onready var Trans := $trans

func _ready():
	pass

func _on_play_pressed():
	Trans.change_scene(game_screen)

func _on_credits_pressed():
	Trans.wipe_in()
	await Trans.animation.animation_finished
	credit.show()
	Trans.wipe_out()


func _on_sound_toggled(button_pressed):
	if button_pressed:
		AudioServer.set_bus_mute(0, true)
	else:
		AudioServer.set_bus_mute(0, false)


func _on_back_pressed():
	Trans.wipe_in()
	await Trans.animation.animation_finished
	credit.hide()
	Trans.wipe_out()
