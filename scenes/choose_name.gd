extends Node

@onready var line_edit = $LineEdit
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	line_edit.connect("text_submitted", Callable(self, "_on_text_submitted"))
	pass # Replace with function body.

func _on_text_submitted(new_text):
	var player_name = new_text.strip_edges()
	if player_name != "":
		Global.player_names.append(player_name)
		line_edit.clear()  # Очистить поле ввода
		print("Имя добавлено в глобальный массив:", player_name)
		get_tree().change_scene_to_file("res://scenes/game.tscn")
	else:
		print("Имя игрока не может быть пустым!")
		
func _process(delta: float) -> void:
	pass
