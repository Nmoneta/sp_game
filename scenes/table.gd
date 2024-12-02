extends Control



@onready var item_list = $ItemList  # Укажите путь к вашему ItemList

func _ready():
	populate_item_list()

func populate_item_list():
	# Очищаем список перед добавлением (на случай перезагрузки)
	item_list.clear()

	# Добавляем имена игроков из Global.player_names
	for player_name in Global.player_names:
		item_list.add_item(player_name)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
