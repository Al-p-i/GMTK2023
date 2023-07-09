extends CanvasLayer

@onready var animation = $trans_anim

func change_scene(target: PackedScene) -> void:
	transition(target)

func transition(target: PackedScene) -> void:
	animation.play('wipe_in')
	await animation.animation_finished
	get_tree().change_scene_to_packed(target)
	animation.play('wipe_out')

func wipe_in() -> void:
	animation.play('wipe_in')

func wipe_out() -> void:
	animation.play('wipe_out')
