extends Node2D

@onready var boat = $Plot
@onready var characters = [$Man1, $Man2, $Man3, $Girl1, $Girl2, $Girl3]

func _ready():
	boat.connect("clicked", Callable(self, "_on_boat_clicked"))
	boat.connect("check", Callable(self, "check_rules"))
	for character in characters:
		character.connect("clicked", Callable(self, "_on_character_clicked"))

func _on_character_clicked(character):
	Global.move += 1
	if boat.passengers.has(character):
		boat.disembark_passenger(character)
	else:
		boat.board_passenger(character)
	print(Global.move)
	

func _on_boat_clicked():
	Global.move += 1
	boat.move_boat()
	print(Global.move)

func check_rules():
	var left_side = [] # Персонажи на левом берегу
	var right_side = [] # Персонажи на правом берегу
	# Разделите персонажей по берегам
	for character in characters:
		if character.is_left:
			left_side.append(character)
		else:
			right_side.append(character)
	var i = 0
	# Проверьте, что девочки не остались с чужими отцами
	for girl in [$Girl1, $Girl2, $Girl3]:
		var arr = [0, 1, 2]
		arr.erase(i)
		if girl.is_left and !characters[i].is_left and (characters[arr[0]].is_left or characters[arr[1]].is_left):
			print("Нарушение правил на левом берегу!")
		if !girl.is_left and characters[i].is_left and (!characters[arr[0]].is_left or !characters[arr[1]].is_left):
			print("Нарушение правил на правом берегу!")
		i+=1
