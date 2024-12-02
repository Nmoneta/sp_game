extends Control


@onready var label = $Label2  # Указываем путь к Label

func _ready():
	# Инициализируем текст Label
	update_label()

# Максимальное количество игроков
var max_players = 10

# Функция для вставки нового игрока с учётом ограничения количества игроков
func insert_player_sorted(new_player: Dictionary):
	var inserted = false
	for i in range(Global.player_names.size()):
		# Сравниваем motion нового игрока с текущим игроком
		if new_player["motion"] > Global.player_names[i]["motion"]:
			# Вставляем нового игрока на нужную позицию
			Global.player_names.insert(i, new_player)
			inserted = true
			break
	# Если новый игрок имеет самый низкий motion, добавляем его в конец массива
	if not inserted:
		Global.player_names.append(new_player)
	
	# Если количество игроков превышает максимальное, удаляем последнего
	if Global.player_names.size() > max_players:
		Global.player_names.pop_back()



func update_label():
	label.text =  "Перестановок: %d\nВремя: %.2f сек" % [Global.motion, Global.elapsed_time]
	insert_player_sorted({"name":Global.player_name, "motion":Global.motion, "time":Global.elapsed_time})
	# Обновляем текст в Label с текущим значением переменной
	
	Global.player_name = ""
	Global.motion = 0
	Global.elapsed_time = 0.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/table.tscn")
