extends Control


@onready var label = $Label2  # Указываем путь к Label

func _ready():
	# Инициализируем текст Label
	update_label()

func update_label():
	# Обновляем текст в Label с текущим значением переменной
	label.text =  "Перестановок: %d\nВремя: %.2f сек" % [Global.motion, Global.elapsed_time]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
