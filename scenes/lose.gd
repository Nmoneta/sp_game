extends Control

signal restart

func _ready() -> void:
	pass # Replace with function body.

func _on_menu_button_2_pressed() -> void:
	emit_signal("restart")	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
