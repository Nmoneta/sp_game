extends Node2D

signal clicked

var left_pos = Vector2(75, 832)
var right_pos = Vector2(1136, 460)
var is_left = true

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		emit_signal("clicked", self)
