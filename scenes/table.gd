extends Control

@onready var item_list = $ItemList  # Укажите путь к вашему ItemList

func _ready():
	# Создаем новый динамический шрифт
	var f = load("res://graphic/FEMussyPussy-Regular.otf")
	$ItemList.add_theme_font_override("font", f)
	$ItemList.add_theme_font_size_override("font_size", 40)

	populate_item_list()

func populate_item_list():
	# Очищаем список перед добавлением (на случай перезагрузки)
	item_list.clear()

	# Добавляем имена игроков из Global.player_names
	for i in range(Global.player_names.size() - 1, -1, -1):
		var player = Global.player_names[i]
		var entry = "Имя: %s | Счёт: %d | Время: %.2f сек" % [player["name"], player["motion"], player["time"]]
		print(entry)
		item_list.add_item(entry)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/start_game.tscn")
