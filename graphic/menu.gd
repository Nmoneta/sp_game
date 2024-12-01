extends Node2D

var config_file_path = "user://save_game.cfg"
var config_file = ConfigFile.new()


func _on_button_2_pressed():
	get_tree().quit()


func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://scenes/office/office.tscn")


func _on_select_day_button_pressed():
	get_tree().change_scene_to_file("res://scenes/load_menu/load_menu.tscn")


func _on_new_game_button_pressed():
	Globals.day = 1
	get_tree().change_scene_to_file("res://scenes/office/office.tscn")
	
	
func _on_options_button_pressed():
	get_tree().change_scene_to_file("res://scenes/settings/settings_menu.tscn")
