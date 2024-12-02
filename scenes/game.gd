extends Node2D

@onready var boat = $Plot
@onready var characters = [$Man1, $Man2, $Man3, $Girl1, $Girl2, $Girl3]
@onready var pause_menu = $PauseMenu

var paused = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		pauseMenu()

func restart():
	Global.move()
	Global.start_game()
	for character in characters:
		character.position = character.left_pos
		
func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else: 
		pause_menu.show()
		Engine.time_scale = 0
	paused = !paused
	

func _ready():
	pause_menu.hide()
	boat.connect("clicked", Callable(self, "_on_boat_clicked"))
	boat.connect("check", Callable(self, "check_rules"))
	Global.start_game()
	for character in characters:
		character.connect("clicked", Callable(self, "_on_character_clicked"))

func _on_character_clicked(character):
	Global.move()
	if boat.passengers.has(character):
		boat.disembark_passenger(character)
	else:
		boat.board_passenger(character)
	

func _on_boat_clicked():
	Global.move()
	boat.move_boat()

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
			Global.game_over()
		if !girl.is_left and characters[i].is_left and (!characters[arr[0]].is_left or !characters[arr[1]].is_left):
			print("Нарушение правил на правом берегу!")
			Global.game_over()
		i+=1
