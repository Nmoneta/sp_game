extends Node2D

signal clicked

var left_pos = Vector2(624, 833)
var right_pos = Vector2(1419, 508)
var is_left = true
var boat_pos = 2

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		emit_signal("clicked", self)
