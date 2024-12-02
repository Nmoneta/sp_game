extends Node2D

@onready var boat = $Plot
@onready var characters = [$Man1, $Man2, $Man3, $Girl1, $Girl2, $Girl3]
@onready var pause_menu = $PauseMenu

var paused = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		pauseMenu()

func restart():
	$Lose.hide()
	$Win.hide()
	Global.motion = 0
	Engine.time_scale = 1
	Global.start_game()
	boat.restart()
	for character in characters:
		character.scale = Vector2(1, 1)
		character.boat_pos = 2
		character.is_left = true
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
	$Lose.connect("restart", Callable(self, "restart"))
	$Win.connect("restart", Callable(self, "restart"))
	Global.start_game()
	$Lose.hide()
	$Win.hide()
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
	var count_in_island = 0
	# Разделите персонажей по берегам
	for character in characters:
		if character.is_left:
			left_side.append(character)
		else:
			right_side.append(character)
	var i = 0
	print(count_in_island)
	# Проверьте, что девочки не остались с чужими отцами
	for girl in [$Girl1, $Girl2, $Girl3]:
		if girl.boat_pos == 2:
			var arr = [0, 1, 2]
			arr.erase(i)
			if girl.is_left and !characters[i].is_left and (characters[arr[0]].is_left or characters[arr[1]].is_left):
				print("Нарушение правил на левом берегу!")
				Global.game_over()
				lose()
			if !girl.is_left and characters[i].is_left and (!characters[arr[0]].is_left or !characters[arr[1]].is_left):
				
				print(girl)
				print("Нарушение правил на правом берегу!")
				Global.game_over()
				lose()
		i+=1
	for character in characters:
		if !character.is_left:
			count_in_island += 1
	if count_in_island == 6:
		print('Это победа братан')
		Global.game_over()
		win()

func _on_texture_button_pressed() -> void:
	pauseMenu() # Replace with function body.
	
func win():	
		$Win.show()
		Engine.time_scale = 0

func lose():
		$Lose.show()
		Engine.time_scale = 0
