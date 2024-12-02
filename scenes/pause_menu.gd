extends Control


@onready var main = $"../"

func _on_button_pressed() -> void:
	main.pauseMenu()


func _on_button_2_pressed() -> void:
	get_tree().quit()


func _on_button_3_pressed() -> void:
	main.restart()
