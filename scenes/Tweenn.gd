extends Tween

class_name CurveTween

signal curve_tween(sat)
@export var curve: Curve
var start = 0.0
var end = 1.0

#func play(duration = 1.0, start_in = 0.0, end_in = 1.0):
#	assert(curve, "this CurveTween needs a curve added in the inspector")
#	start = start_in
#	end = end_in
#	interpolate_value(self, "interp", 0.0, 1.0, duration, Tween.TRANS_LINEAR, Tween.EASE_IN)
#	start()
	
func interp(sat):
	emit_signal("curve_tween", start + ((end - start) * curve.interpolate(sat)))
