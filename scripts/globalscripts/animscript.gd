extends Node


func update_control_scale(controls):
	if controls is Array:
		for c in controls:
			control_hov(c, 1.1, 0.2)
	else:
		control_hov(controls, 1.1, 0.2)


func control_hov(control: Control, tween_amt: float, duration: float) -> void:
	control.pivot_offset = control.size / 2
	if control.is_hovered():
		tween_property_smooth(control, "scale", Vector2.ONE * tween_amt, duration)
	else:
		tween_property_smooth(control, "scale", Vector2.ONE, duration)


func tween_property_smooth(control: Control, property: String, amount, duration: float) -> void:
	var tw = create_tween()
	tw.tween_property(control, property, amount, duration)


func update_label_scale(label: Label, tween_amt: float = 1.09, duration: float = 0.35) -> void:
	
	# Ensure the label receives mouse input
	label.mouse_filter = Control.MOUSE_FILTER_STOP
	label.pivot_offset = label.size / 2

	# Connect signals (safe so they don't double-connect)
	if not label.is_connected("mouse_entered", Callable(self, "_on_label_hover")):
		label.connect("mouse_entered", Callable(self, "_on_label_hover").bind(label, tween_amt, duration))
	if not label.is_connected("mouse_exited", Callable(self, "_on_label_exit")):
		label.connect("mouse_exited", Callable(self, "_on_label_exit").bind(label, duration))


func _on_label_hover(label: Label, tween_amt: float, duration: float) -> void:
	tween_property_smooth(label, "scale", Vector2.ONE * tween_amt, duration)


func _on_label_exit(label: Label, duration: float) -> void:
	tween_property_smooth(label, "scale", Vector2.ONE, duration)
