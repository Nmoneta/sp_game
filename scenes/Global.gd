extends Node

var player_names: Array = []
var motion = 0
var end_time: int
var start_time: int
var elapsed_time: int

func game_over():
	# Сохраняем текущее время в миллисекундах (время окончания игры)
	end_time = Time.get_ticks_msec()
	# Вычисляем разницу между временем окончания и началом
	elapsed_time = (end_time - start_time)/100
	# Выводим прошедшее время (в миллисекундах)
	print("Время игры: " + str(elapsed_time) + " секунд")

func start_game():
	start_time = Time.get_ticks_msec()

func move():
	motion+=1
