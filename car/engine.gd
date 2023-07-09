extends Node2D
@onready var area_2d = $Area2D
@onready var progress_bar = $ProgressBar
@onready var fire_timer = $FireTimer
@onready var fire_animation = $FireAnimation
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	fire_animation.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		#enum TOOL_TYPES { FIRE_EXTINGUISHER, SCREWDRIVER, JACK, TYRE, WIPER, FUEL }
		if Global.selected_tool == null:
			print("no tool selected")
		elif Global.selected_tool.tool_type == Global.TOOL_TYPES.FIRE_EXTINGUISHER:
			#use_fire_extinguisher()
			pass
		elif Global.selected_tool.tool_type == Global.TOOL_TYPES.FUEL:
			# if car is on fire and you fuel it - we set fire on MAX
			if progress_bar.value < 100:
				set_engine_state(0)
		else:
			print("wrong tool selected ", Global.selected_tool)

func set_engine_state(value: int):
	progress_bar.value = value
	if progress_bar.value >= 100:
		fire_animation.hide()
		fire_timer.stop()
	else:
		fire_animation.show()
		fire_animation.global_scale = Vector2(1.2 - progress_bar.value/100, 1.2 - progress_bar.value/100)

func _on_fire_timer_timeout():
	progress_bar.value -= 1
	fire_animation.global_scale = Vector2(1.2 - progress_bar.value/100, 1.2 - progress_bar.value/100)
	if Global.selected_tool and Global.selected_tool.tool_type == Global.TOOL_TYPES.FIRE_EXTINGUISHER:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			use_fire_extinguisher()
	

func use_fire_extinguisher():
	var distance := get_global_mouse_position().distance_to(fire_animation.global_position)
	progress_bar.value += max(0, 14 - sqrt(distance + 20))
	fire_animation.global_position += Vector2(rng.randi_range(-20,20), rng.randi_range(-10,15))
	fire_animation.global_scale = Vector2(1.2 - progress_bar.value/100, 1.2 - progress_bar.value/100)
	if progress_bar.value >= 100:
		fire_timer.stop()
		fire_animation.hide()
