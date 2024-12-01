extends Node2D

# Переменные для управления
var passengers = [] # Список персонажей в лодке
var is_on_left_shore = true # Лодка находится на левом берегу
signal clicked 
# Ссылки на берега
var left_shore_position = Vector2(1123,871)
var right_shore_position = Vector2(1504,685)

var is_free_pos1 = true
var is_free_pos2 = true

func _ready():
	$Area2D.connect("input_event", Callable(self, "_on_area_input_event"))

# Перемещение лодки
func move_boat():
	if len(passengers) == 0:
		print("Лодка пуста! Нужен хотя бы один пассажир.")
		return
	var vect = 1
	if not is_on_left_shore:
		vect = -1

	is_on_left_shore = not is_on_left_shore
	var target_position = right_shore_position if not is_on_left_shore else left_shore_position
	var tween = get_tree().create_tween()
	var tween_pass1 = get_tree().create_tween()
	tween.tween_property(self, "position", target_position, 2.0)
	tween_pass1.tween_property(passengers[0], "position", passengers[0].position + Vector2(381, -186)*vect, 2.0)
	passengers[0].is_left = is_on_left_shore
	if len(passengers) == 2:
		var tween_pass2 = get_tree().create_tween()
		tween_pass2.tween_property(passengers[1], "position", passengers[1].position + Vector2(381, -186)*vect, 2.0)
		passengers[1].is_left = is_on_left_shore
		

# Посадка в лодку
func board_passenger(person):
	if len(passengers) >= 2:
		print("Лодка переполнена!")
		return
	if passengers.has(person):
		print("Этот пассажир уже в лодке!")
		return
	if (is_on_left_shore and not person.is_left or not is_on_left_shore and person.is_left):
		print("Этот пассажир на другом берегу")
		return
	
	var pos1 = Vector2(1120, 664)
	var pos2 = Vector2(1264, 616)
	
	if (not is_on_left_shore):
		pos1 = Vector2(1501, 478)
		pos2 = Vector2(1645, 430)
	
	if len(passengers) == 0:
		person.position = pos1 # Смещаем персонажей в лодке
	else: 
		person.position = pos2 # Смещаем персонажей в лодке
	person.scale = Vector2(1, 1)
	passengers.append(person)
	

# Высадка из лодки
func disembark_passenger(person):
	if passengers.has(person):
		passengers.erase(person)
		person.position = person.left_pos if is_on_left_shore else person.right_pos
		if is_on_left_shore:
			person.position = person.left_pos
			person.scale = Vector2(1, 1)
		else: 
			person.position = person.right_pos
			person.scale = Vector2(0.5, 0.5)


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		emit_signal("clicked")  # Генерируем сигнал при кликеdy.
