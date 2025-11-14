extends Node2D

#creates a variable game_scene
var game_scene = "res://scenes/game_screen.tscn"

#called when the node enters the scene tree for the first time
func _ready():
	pass

#called every frame. 'delta' is the elapsed time since the previous frame
func _process(_delta: float) -> void:
	pass

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file(game_scene)

func _on_settings_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/SettingsScreen.tscn")

func _on_exit_button_pressed() -> void:
	get_tree().quit()
