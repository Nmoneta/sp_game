extends Node2D

@onready var boat = $Plot
@onready var characters = [$Man1, $Man2, $Man3, $Girl1, $Girl2, $Girl3]

func _ready():
	boat.connect("clicked", Callable(self, "_on_boat_clicked"))
	for character in characters:
		character.connect("clicked", Callable(self, "_on_character_clicked"))

func _on_character_clicked(character):
	if boat.passengers.has(character):
		boat.disembark_passenger(character)
	else:
		boat.board_passenger(character)

func _on_boat_clicked():
	boat.move_boat()
